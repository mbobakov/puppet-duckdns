require 'spec_helper'

describe 'duckdns' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "duckdns class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('duckdns::params') }
        it { should contain_class('duckdns::install').that_comes_before('duckdns::config') }
        it { should contain_class('duckdns::config') }
        it { should contain_class('duckdns::service').that_subscribes_to('duckdns::config') }

        it { should contain_service('duckdns') }
        it { should contain_package('duckdns').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'duckdns class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('duckdns') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
