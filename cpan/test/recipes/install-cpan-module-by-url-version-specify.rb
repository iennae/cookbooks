cpan_client 'http://search.cpan.org/CPAN/authors/id/M/ME/MELEZHIK/Bundler-v0.0.30.tar.gz' do
    install_type 'cpan_module'
    user 'root'
    group 'root'
    action 'install'
end
cpan_client 'http://search.cpan.org/CPAN/authors/id/M/ME/MELEZHIK/Bundler-v0.0.29.tar.gz' do
    install_type 'cpan_module'
    module_name 'Bundler'
    user 'root'
    group 'root'
    action 'install'
end

