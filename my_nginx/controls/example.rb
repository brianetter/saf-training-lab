control 'nginx-version' do
  impact 1.0
  title 'NGINX version'
  desc 'The required version of NGINX should be installed.'
  describe nginx do
    its('version') { should cmp >= input('nginx_version') }
    # its('version') { should cmp >= '1.27.0' }
  end
end

control 'nginx-modules' do
  impact 1.0
  title 'NGINX modules'
  desc 'The required NGINX modules should be installed'

  nginx_modules = input('nginx_modules')

  describe nginx do
    # its('modules') { should include 'http_ssl' }
    # its('modules') { should include 'stream_ssl' }
    # its('modules') { should include 'mail_ssl' }
    nginx_modules.each do |current_module|
      its('modules') { should include current_module }
    end
  end
end

control 'nginx-config-file' do
  impact 1.0
  title 'NXINX configuration file'
  desc 'The NGINX config file should exist as a file'
  describe file('/etc/nginx/nginx.conf') do
    it { should be_file }
  end
end

control 'nginx-conf-perms' do
  impact 1.0
  title 'NGINX configuration'
  desc 'The NGINX config file should be owned by root, be writable only by owner, and not writeable or and readable by others.'
  describe file('/etc/nginx/nginx.conf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should_not be_executable.by('others') }
  end
end

control 'nginx-shell-access' do
  impact 1.0
  title 'NGINX shell access'
  desc 'NGINX shell access should be restricted to admin users'
  describe users.shells(/bash/).usernames do
    it { should be_in input('admin_users') }
  end
end

control 'nginx-interview' do
  impact 1.0
  title 'NGINX interview'
  desc 'NGINX admins should have documentation on security procedures'
  describe "Manual Review" do
    skip "This control must be manually reviewed."
  end
end