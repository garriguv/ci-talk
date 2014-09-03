class Codesign
  attr_reader :signing_identity, :provisioning_profile

  def initialize(signing_identity, provisioning_profile)
    @signing_identity = signing_identity
    @provisioning_profile = provisioning_profile
  end
end
