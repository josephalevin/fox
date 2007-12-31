module FoX_utils
  
  use fox_m_utils_uuid
  use fox_m_utils_uri

  implicit none
  private

  public :: generate_uuid

  public :: URI
  public :: parseURI
  public :: rebaseURI
  public :: destroyURI
  public :: expressURI

end module FoX_utils
