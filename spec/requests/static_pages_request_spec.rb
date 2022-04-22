require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "titleに Ruby on Rails Tutorial Sample Appが表示される" do
      get root_path
      expect(response.body).to include "#{base_title}"
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get help_path
      expect(response).to have_http_status(:success)
    end

    it "titleにHelp | Ruby on Rails Tutorial Sample Appが表示される" do
      get help_path
      expect(response.body).to include "Help | #{base_title}"
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get about_path
      expect(response).to have_http_status(:success)
    end

    it "titleにAbout | Ruby on Rails Tutorial Sample Appが表示される" do
      get about_path
      expect(response.body).to include "About | #{base_title}"
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get contact_path
      expect(response).to have_http_status(:success)
    end

    it "titleにContact | Ruby on Rails Tutorial Sample Appが表示される" do
      get contact_path
      expect(response.body).to include "Contact | #{base_title}"
    end
  end

end
