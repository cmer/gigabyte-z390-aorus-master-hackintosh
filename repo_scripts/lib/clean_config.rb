require 'plist'
require 'json'

class CleanConfig
  attr_reader :config_path

  CHANGE_ME = "{{CHANGE ME}}"

  def initialize(config_path)
    @config_path = config_path
  end

  def clean!
    result = Plist.parse_xml(config_path)

    result['PlatformInfo']['Generic']['SystemSerialNumber'] = CHANGE_ME
    result['PlatformInfo']['Generic']['SystemUUID'] = CHANGE_ME
    result['PlatformInfo']['Generic']['MLB'] = CHANGE_ME

    result.save_plist(config_path)
    true
  end
end