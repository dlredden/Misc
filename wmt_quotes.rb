require 'yahoofinance' 

@date = Date.parse('2000-07-14')
@purchase = 45
@total_paid = 0
@whole_shares = 0

p "Date      => Quote => SP   => WSO"

(0..26).each { |i|
	YahooFinance::get_HistoricalQuotes('WMT', @date + (i * 14), @date + (i * 14)) do |quote|
		@shares = ((@purchase/quote.close) * 10**2).round.to_f / 10**2
		@whole_shares += @shares
		@total_paid += @purchase
		p "#{quote.date} => #{quote.close} => #{@shares} => #{@whole_shares}"
	end
}

YahooFinance::get_HistoricalQuotes('WMT', Date.parse('2009-02-03'), Date.parse('2009-02-03')) do |quote|
	p "#{quote.date} => #{quote.close}"
end

p "Total Paid for #{@whole_shares} Shares of WMT Stock: $#{@total_paid}"
