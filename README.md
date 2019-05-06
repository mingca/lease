# Lease

Simplify the lease pdf/html management. Specially designed for a real estate self-storage project.

## Usage
1. `rails g lease:install`
`rake db:migrate`

2. On any model you want to treat as a "signer" of an envelope/template, add `lease_signable`:
```ruby
class User < ApplicationRecord

  lease_signable

end
```
3. On any model you want treat as a leasing property, add `lease_envelopable`:
```ruby
class Occupancy < ApplicationRecord

  lease_envelopable

end
```
4. You can now call some methods like:
```ruby
user = User.new(full_name:'Jason Smolar') # the signable model
occupancy = Occupancy.new # the leasable model
template = Lease::Template.create(state: 'CA', template: File.open('/tmp/ca_lease_template.html'))
envelope = user.create_envelope(template: template, envelopable: occupancy)
vars = { # hash of variables to be interpolated into html file. Pass html id to hash key.
  rental_price: '$12', # there should be a html DOM in the template file with the id 'rental_price'
  ...
}
if user.has_unsigned_lease?
  envelope = user.envelopes.unsigned.first
  envelope.unsigned_html(vars) # returns html without tenant sign
  envelope.with_unsigned_pdf(vars) do |pdf_file|
    pdf_file.read # pdf_file is temporary use only and will be deleted after this block
  end
  envelope.unsigned? # true
  # Generate and returns the signed pdf. PDF is stored in 
  envelope.sign(vars)
  envelope.signed_pdf # Carrierwave::Storage::File
  envelope.signed? # true
end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mingca/lease. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT](https://opensource.org/licenses/MIT).

