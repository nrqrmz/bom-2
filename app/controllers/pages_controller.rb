class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    require 'open-uri'
    json = File.join(__dir__, "../../book_of_mormon.json")
    api = JSON.parse(File.read(json))
    @bom = api
  end
end
