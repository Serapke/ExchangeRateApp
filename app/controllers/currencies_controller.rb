require 'open-uri'

class CurrenciesController < ApplicationController

  helper_method :convert_currency

  DATA_URL = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  RATE_ROUND_PRECISION = 4

  def index
    @currencies = ExchangeRate::Record.select(:currency).distinct
    if params[:date]
      @date = params[:date][:date]
    end
    @amount = params[:amount]
    @from = params[:from]
    @to = params[:to]

    if !@date.nil? && !@from.nil? && !@to.nil?
      @answer = ExchangeRate::Rate.instance.at(@date, @from, @to).round(RATE_ROUND_PRECISION) * @amount.to_f
    end
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  # Fetches xml data from source and updates the database if needed
  def get_currencies
    @last_updated = ExchangeRate::Record.maximum('date');
    xml = Hash.from_xml(open(DATA_URL))
    n = xml['Envelope']['Cube']['Cube'].count
    (0..n-1).each do |i|
      @date = xml['Envelope']['Cube']['Cube'][i]['time'];
      @data = xml['Envelope']['Cube']['Cube'][i]['Cube'];
      if @last_updated.nil? || @last_updated < Date.parse(@date)
        @data.each do |rate|
          p "#{@date} #{rate["currency"]} #{rate["rate"]}"
          ExchangeRate::Rate.instance.set(rate['currency'], rate['rate'], @date)
        end
        ExchangeRate::Rate.instance.set('EUR', 1.0, @date)
      end
    end
    redirect_to action: :index
  end
end
