module AmericanStatesHelper
  def american_states
  american_states_array = %w{
      Alabama               
      Alaska
      Arizona
      Arkansas
      California
      Colorado
      Connecticut
      Delaware
      Florida
      Georgia
      Hawaii
      Idaho
      Illinois
      Indiana
      Iowa
      Kansas
      Kentucky
      Louisiana
      Maine
      Maryland
      Massachusetts
      Michigan
      Minnesota
      Mississippi
      Missouri
      Montana
      Nebraska
      Nevada
      NewHampshire
      New\ Jersey
      New\ Mexico
      New\ York
      North\ Carolina
      North\ Dakota
      Ohio
      Oklahoma
      Oregon
      Pennsylvania
      Rhode\ Island
      South\ Carolina
      South\ Dakota
      Tennessee
      Texas
      Utah
      Vermont
      Virginia
      Washington
      West\ Virginia
      Wisconsin
      Wyoming
  }
    american_states_array.sort_by{ |e| e.downcase }
  end
end
