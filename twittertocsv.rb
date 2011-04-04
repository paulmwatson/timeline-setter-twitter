require 'rubygems'
require 'fastercsv'
require 'twitter'

FasterCSV.open('friends.csv', "w") do |csv|
  csv << ['date', 'display_date', 'description', 'link', 'series', 'html']
  %w"paulmwatson theolynn ferguskelly damienmulley".each do |user|
    Twitter.user_timeline(user).each do |status|
      csv << [status.created_at, status.created_at, status.text, "http://twitter.com/#{status.user.screen_name}/status/#{status.id}", status.user.screen_name, '<img src="' + status.user.profile_image_url + '" />']
    end
  end
end

`mkdir friends`
`timeline-setter -c friends.csv -o friends -a`
`mv friendstimeline.html friends`
`open friends/friendstimeline.html`