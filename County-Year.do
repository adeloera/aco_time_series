*County Spending Analysis
*By Andres de Loera-Brust

clear all
cd "C:/Users/Andres/Documents/Harvard/Senior Year/HCP/aco_time_series"

*Install Outreg commands
ssc install outreg
ssc install outreg2

*Import the dataset
import delim using "county_year_master_file.csv"


*Variable Creation

gen log_pc_spending = log(actual_per_capita_costs)

xtset state_and_county_fips_code year

bys state_and_county_fips_code: g spend_growth = 100*(actual_per_capita_costs[_n]-actual_per_capita_costs[_n-1])/actual_per_capita_costs[_n-1]

bys state_and_county_fips_code: g actual_per_capita_costs_l1 = actual_per_capita_costs[_n-1]

bys state_and_county_fips_code: g spend_growth_l1 = spend_growth[_n-1]

bys state_and_county_fips_code: g spend_growth_3yr = 100*(actual_per_capita_costs[_n]-actual_per_capita_costs[_n-3])/actual_per_capita_costs[_n-3]

*Labeling

label variable actual_per_capita_costs "Per Capita Spending"

*Figures

twoway (scatter actual_per_capita_costs actual_per_capita_costs_l1)

twoway (scatter spend_growth spend_growth_l1, mcolor(%25) msize(small)), ytitle(Spending Growth Year T) xtitle(Spending Growth Year T-1) title(Regression to the Mean in County Spending Growth)

twoway (scatter spend_growth actual_per_capita_costs_l1, mcolor(%25) msize(small)), ytitle(Spending Growth Year T) xtitle(Per Capita Spending Year T-1) title(Regression to the Mean in County Spending Growth)

*Regressions

xtreg spend_growth l.actual_per_capita_costs, r

outreg2 using output/County_Spending_Results.doc, replace ctitle("T-1") dec(5) nonotes title(Table X. Lagged Per Capita Spending on Spending Growth) addnote(NOTE--Table reports regression coefficients with robust standard errors in parentheses. The dependent variable in each regression is the growth in Medicare per capita spending at the county-year level., ***p<0.01 **p<0.05 *p<0.1)

xtreg spend_growth l2.actual_per_capita_costs, r

outreg2 using output/County_Spending_Results.doc, append ctitle("T-2") dec(5)

xtreg spend_growth l3.actual_per_capita_costs, r

outreg2 using output/County_Spending_Results.doc, append ctitle("T-3") dec(5)

xtreg spend_growth l4.actual_per_capita_costs, r

outreg2 using output/County_Spending_Results.doc, append ctitle("T-4") dec(5)

xtreg spend_growth l5.actual_per_capita_costs, r

outreg2 using output/County_Spending_Results.doc, append ctitle("T-5") label dec(5)

**** 

xtreg spend_growth_3yr l3.spend_growth_3yr, r

outreg2 using Output/County_Spending_Results_2.doc, replace ctitle("") dec(5) nonotes addnote(NOTE--Table reports regression coefficients with robust standard errors in parentheses. The dependent variable in each regression is the 3 year growth rate in Medicare per capita spending at the county-year level., ***p<0.01 **p<0.05 *p<0.1)


