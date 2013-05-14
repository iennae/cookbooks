class PintoSpec < MiniTest::Chef::Spec

    describe 'installs pintod server' do

        it 'creates pinto repo directory' do
            directory("#{node[:pinto][:server][:repo_root]}").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            directory("#{node[:pinto][:server][:repo_root]}").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
        end

        it 'creates pintod init script' do
            file('/etc/init.d/pintod').must_exist.with(:owner, 'root')
            file('/etc/init.d/pintod').must_exist.with(:group, 'root')
            file('/etc/init.d/pintod').must_have(:mode, "755")
        end

        it 'runs pintod server' do

            result = assert_sh('/etc/init.d/pintod status')
            assert_includes result, 'is running'

            pid = `cat /var/run/pintod.pid`.chomp!
            result = assert_sh("ps --ppid #{pid} | wc -l")
            assert_includes result, (node[:pinto][:server][:workers].to_i + 1).to_s

            result = assert_sh("curl -If http://#{node[:pinto][:server][:host]}:#{node[:pinto][:server][:port]}/modules/03modlist.data.gz")
            assert_includes result, ' 200 OK'
        end

    end    
end

