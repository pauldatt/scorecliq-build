module CanadianProvincesHelper
  def canadian_provinces
  canadian_provinces_array = %w{
      Alberta
      British\ Columbia
      Manitoba
      New\ Brunswick
      Newfoundland
      Northwest\ Territories
      Nova\ Scotia
      Nunavut
      Ontario
      Prince\ Edward\ Island
      Quebec
      Saskatchewan
      Yukon
  }
    canadian_provinces_array.sort_by{ |e| e.downcase }
  end
end

