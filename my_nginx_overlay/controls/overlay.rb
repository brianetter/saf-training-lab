# require_controls 'my_nginx' do
#   control 'nginx-version'
#   control 'nginx-modules'
# end

include_controls 'my_nginx' do
  control 'nginx-modules' do
    impact 0.5
  end
  control 'nginx-conf-file'
end