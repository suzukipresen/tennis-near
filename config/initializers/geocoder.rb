Geocoder.configure(
  lookup: :nominatim,
  use_https: true,
  http_headers: {
    "User-Agent" => "tennis-near"
  }
)