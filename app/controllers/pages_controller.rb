class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about testimonies]

  def home
    @bom = book_of_mormon
  end

  def about
    @bom = book_of_mormon
  end

  def testimonies
    @bom = book_of_mormon
    @bom_data = word_counter(@bom['testimonies'][0]['text'])
    @bom_data2 = word_counter(@bom['testimonies'][1]['text'])
  end

  private

  def book_of_mormon
    require 'open-uri'
    json = File.join(__dir__, "../../book_of_mormon.json")
    JSON.parse(File.read(json))
  end

  def word_counter(text)
    stop_words = %w[the and of to in a that it is was i for he you as his with be not are this but they on have at by she or an we do from which one would all will there say who make when can more if unto our also us]

    text.tr('.,;:?!', '').split.map(&:downcase).reject { |w| stop_words.include? w }.tally.sort_by { |_, v| -v }.to_h
  end
end
