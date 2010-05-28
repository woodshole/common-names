# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def bar_graph(amount, total)
    percentage = amount.to_f / total.to_f * 100
    rounded_percent = (percentage * 10).round.to_f / 10
    haml_tag :div, :class => 'bar_graph' do
      haml_tag :span, "#{amount} / <span class='total'>#{total}</span>", :class => 'amount'
      haml_tag :span, "#{rounded_percent}%",  :class => 'percentage',
                                              :style => "width: #{percentage}%; text-indent: #{percentage + 1}%"
    end
  end
end
