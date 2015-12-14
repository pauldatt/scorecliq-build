module StatesHelper
  def states
  states_array = %w{
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
      
                                          
      Australian\ Capital\ Territory
      New\ South\ Wales
      Northern\ Territory
      Queensland
      South\ Australia
      Tasmania
      Victoria
      Western\ Australia

                                              
      Acre
      Alagoas
      Amapá
      Amazonas
      Bahia
      Ceará
      Distrito\ Federal
      Espírito\ Santo
      Goiás
      Maranhão
      Mato\ Grasso
      Mato\ Grosso\ do\ Sul
      Minas\ Gerais
      Paraná
      Paraíba
      Pará
      Pernambuco
      Piauí
      Rio\ Grande\ do\ Norte
      Rio\ Grande\ do\ Sul
      Rio\ de\ Janeiro
      Rondônia
      Roraima
      Santa\ Catarina
      Sergipe
      São\ Paulo
      Tocantins
      
                                              
      Baden-Württemberg
      Bayern
      Berlin
      Brandenburg
      Bremen
      Hamburg
      Hessen
      Mecklenburg-Vorpommern
      Niedersachsen
      Nordrhein-Westfalen
      Rheinland-Pfalz
      Saarland
      Sachsen
      Sachsen-Anhalt
      Schleswig-Holstein
      Thüringen

                                                 
      Carlow
      Cavan
      Clare
      Cork
      Donegal
      Dublin
      Galway
      Kerry
      Kildare
      Kilkenny
      Laois
      Leitrim
      Limerick
      Longford
      Louth
      Mayo
      Meath
      Monaghan
      Offaly
      Roscommon
      Sligo
      Tipperary
      Waterford
      Westmeath
      Wexford
      Wicklow

                                                
      Aguascalientes
      Baja\ California
      Baja\ California\ Sur
      Campeche
      Chiapas
      Chihuahua
      Coahuila
      Colima
      Distrito\ Federal
      Durango
      Guanajuato
      Guerrero
      Hidalgo
      Jalisco
      Michoacán
      Morelos
      México
      Nayarit
      Nuevo\ León
      Oaxaca
      Puebla
      Querétaro
      Quintana\ Roo
      San\ Luis\ Potosi
      Sinaloa
      Sonora
      Tabasco
      Tamaulipas
      Tlaxcala
      Veracruz
      Yucatán
      Zacatecas
      
                                           
      Drenthe
      Flevoland
      Friesland
      Gelderland
      Groningen
      Limburg
      Noord-Brabant
      Noord-Holland
      Overijssel
      Utrecht
      Zee\ land
      Zuid-Holland
      
    }
    states_array.sort_by{ |e| e.downcase }
  end
end
 
