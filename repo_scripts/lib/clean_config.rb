require 'plist'
require 'json'

class CleanConfig
  attr_reader :config_path

  GENERATE_ME = "{{GENERATE ME}}"

  def initialize(config_path)
    @config_path = config_path
  end

  def clean!
    result = Plist.parse_xml(config_path)

    result['SMBIOS']['BoardSerialNumber'] = GENERATE_ME
    result['SMBIOS']['SerialNumber'] = GENERATE_ME
    result['SMBIOS']['SmUUID'] = GENERATE_ME
    result['RtVariables']['MLB'] = "{{PASTE BOARD SERIAL NUMBER HERE}}"
    result['Boot']['DefaultVolume'] = 'LastBootedVolume'
    result['GUI']['Theme'] = 'embedded'
    result['GUI']['ScreenResolution'] = ''

    result.save_plist(config_path)
    true
  end
end