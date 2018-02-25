json.extract! page, :id, :name, :title, :text, :created_at, :updated_at
json.url page_url(page, format: :json)
