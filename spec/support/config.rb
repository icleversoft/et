require 'spec_helper'
require 'yaml'

shared_context "shared_data" do
  let(:stages){ YAML.load_file( File.join(File.dirname(__FILE__), 'fixtures', 'stages.yml') )}
end
