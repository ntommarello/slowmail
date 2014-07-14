json.city @letter.city
json.sal @letter.salutation
json.date_written  "#{Time.now.strftime("%B %d, %Y")}"
json.content @letter.content