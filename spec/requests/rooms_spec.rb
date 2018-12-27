require "rails_helper"

RSpec.describe "Rooms resources", type: :request do

  def expect_redirect_and_message(message, redirect_path = root_path)
    expect(response).to redirect_to redirect_path
    follow_redirect!
    expect(response.body).to include(message)
  end

  subject { create(:room) }
  let(:room_params) { { room: { title: "Room", hidden: false } } }

  describe "GET /rooms" do
    context "where user is admin" do
      it "has admin actions column" do
        sign_in create(:admin)

        get rooms_path

        expect(response.body).to include("Actions")
      end

      it "shows all rooms" do
        sign_in create(:admin)
        create_list(:room, 5)
        create_list(:hidden_room, 1)

        get rooms_path

        expect(response.body).to include("Yes")
      end
    end

    context "where user is not admin" do
      it "has not admin actions column" do
        sign_in create(:user)

        get rooms_path

        expect(response.body).not_to include("Actions")
      end

      it "shows all rooms" do
        sign_in create(:user)
        create_list(:room, 5)
        create_list(:hidden_room, 1)

        get rooms_path

        expect(response.body).not_to include("Yes")
      end
    end
  end

  describe "GET /rooms/new" do
    it "shows new room form only for admin" do
      sign_in create(:admin)

      get new_room_path

      expect(response.body).to include("Create")
    end

    it "does not show new room form for user" do
      sign_in create(:user)

      get new_room_path

      expect_redirect_and_message("This action available ony for admins!")
    end
  end

  describe "POST /rooms" do
    it "allows admin to create room" do
      sign_in create(:admin)

      post rooms_path, params: room_params

      expect_redirect_and_message("Room successfully created!", rooms_path)
    end

    it "does not allow user to update room" do
      sign_in create(:user)

      post rooms_path, params: room_params

      expect_redirect_and_message("This action available ony for admins!")
    end
  end

  describe "GET /rooms/:id/edit" do
    it "shows edit room form only for admin" do
      sign_in create(:admin)

      get edit_room_path(subject)

      expect(response.body).to include("Update")
    end

    it "does not show edit room form for user" do
      sign_in create(:user)

      get edit_room_path(subject)

      expect_redirect_and_message("This action available ony for admins!")
    end
  end

  describe "PUT /rooms/update" do
    it "allows admin to update room" do
      sign_in create(:admin)

      put room_path(subject), params: room_params

      expect_redirect_and_message("Room successfully updated!", rooms_path)
    end

    it "does not allow user to update room" do
      sign_in create(:user)

      put room_path(subject), params: room_params

      expect_redirect_and_message("This action available ony for admins!")
    end
  end

  describe "DELETE /rooms/:id" do
    it "allows admin to delete room" do
      sign_in create(:admin)

      delete room_path(subject)

      expect_redirect_and_message("#{subject.title} room successfully deleted!", rooms_path)
    end

    it "does not allow user to delete room" do
      sign_in create(:user)

      delete room_path(subject)

      expect_redirect_and_message("This action available ony for admins!")
    end
  end
end
