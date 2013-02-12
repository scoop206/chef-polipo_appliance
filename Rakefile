task :test do

  # start applicance, writing ip to file
  #`./bootstrap.sh test/integration/proxy_ip`

  cmd = "./bootstrap.sh test/integration/proxy_ip"
  pipe = IO.popen(cmd)
  while (line = pipe.gets)
    print line
  end

  # run kitchen tests against proxy clients

  Dir.chdir("test/integration")
  proxy_ip =`cat proxy_ip`.chomp
  `sed -i -e "s/proxy_ipaddress: PROXY_IP/proxy_ipaddress: #{proxy_ip}/" .kitchen.yml`

  cmd = "bundle exec kitchen test"
  pipe = IO.popen(cmd)
  while (line = pipe.gets)
    print line
  end  
end
