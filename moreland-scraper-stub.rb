# this script borrows heavily from https://github.com/planningalerts-scrapers/moreland
# unlike the Planning Alerts scraper, which scrapes for new planning applications, this scraper gleans
# planning applications for which a decision has been made (by the council)

require 'mechanize'
require 'logger'

agent = Mechanize.new

agent.log = Logger.new "mechanize.log"


url="https://eservices.moreland.vic.gov.au/ePathway/Production/Web/GeneralEnquiry/ExternalRequestBroker.aspx?Module=EGELAP&Class=SUB&Type=SUBDEC"


# to get to the page we're really interested in - the page with the table of planning applications - we must first
# visit the prior page.  This ensures the relevant session cookies are setup

page = agent.get(url)

# move through first page 
form = page.forms.first



# TEST 01: 
# Navigate to the page that lists each 'Planning Permit Applications advertised' in an HTML table
# Do this, by selecting the relevant option in drop-down then hitting the form's search button
puts '*******TEST 01 start ***********\n'
# select the dropdown option: 'Planning Permit Applications advertised' 
form.field_with(name: 'ctl00$MainBodyContent$mGeneralEnquirySearchControl$mEnquiryListsDropDownList').value = 15
pageWithPlanningPermitApplications = form.submit(form.button_with(value: "Search"))
pp pageWithPlanningPermitApplications.links
# you will note in output, you willsee things like 'MPS/2017/XX', showing we've succesfully navigated 
# to the page with the table listing each planning application
puts '*******TEST 01 end ***********\n'


# TEST 02: Navigate to the page listing each 'Planning Permit Decisions' in an HTML table
# Do this, by selecting the relevant option in drop-down then hitting the form's search button
puts '*******TEST 02 start ***********\n'
# THIS DOES NOT WORK :-(
# select the dropdown option: 'Planning Permit Decisions'
form.field_with(name: 'ctl00$MainBodyContent$mGeneralEnquirySearchControl$mEnquiryListsDropDownList').value = 14
pageWithPlanningPermitDecisions = form.submit(form.button_with(value: "Search"))
pp pageWithPlanningPermitDecisions.links
# you will note in output, there is nothing like 'MPS/2017/XX'.  It would seem we've not been able to get to the page
#listing the decided planning applications
puts '*******TEST 02 end ***********\n'

# Why oh Why does TEST 01 succeed, but not TEST02?







