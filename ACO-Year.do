*ACO-Year File Analysis
*Andres de Loera-Brust

clear all
cd "C:/Users/Andres/Documents/Harvard/Senior Year/HCP/aco_time_series"

*Install Outreg commands
ssc install outreg
ssc install outreg2

*Import the dataset
import delim using "aco_year_master_file.csv"

*Set as time series
egen aco_id = group(aco_num)
xtset aco_id year

*Edit the data
gen quality_score = real(qual_score)
drop qual_score

*Create new variables
bys aco_id: g spend_growth = 100*(per_cap_exp[_n]-per_cap_exp[_n-1])/per_cap_exp[_n-1]
bys aco_id: g spend_growth_3yr = 100*(per_cap_exp[_n]-per_cap_exp[_n-3])/per_cap_exp[_n-3]
bys aco_id: g spend_growth_l1 = spend_growth[_n-1]
bys aco_id: g per_cap_exp_l1 = per_cap_exp[_n-1]

*Label the variables
lab var aco_num "ACO ID"
lab var aco_id "Panel ID"
lab var aco_name "ACO Name"
lab var aco_state "States of Operation"
lab var initial_start_date "First Contract Data"
lab var number_of_benes "Number of Beneficiaries"
lab var rate_save_loss "Savings Rate"
lab var bnchmk_min_exp "Benchmark Minus Expenditures"
lab var gen_save_loss "Generated Savings"
lab var earn_save_loss "Shared Savings Earned"
lab var per_cap_bnchmk "Per Capita Benchmark"
lab var total_bnchmk "Total Benchmark"
lab var total_exp "Total Expenditures"
lab var per_cap_exp "Per Capita Spending"
lab var final_share_rate "Shared Savings Rate"
lab var service_length "Days of ACO Operation"
lab var year "Year"
lab var entered "Entered MSSP This Year"
lab var exit "Exited MSSP This Year"
lab var counties "Number of Counties"
lab var quality_score "Quality Score"
lab var spend_growth "Per Capita Spending Growth"
lab var spend_growth_3yr "3 Year Per Capita Spending Growth"

*Analysis

*Spending on Spending
xtreg per_cap_exp l.per_cap_exp, r

outreg2 using output/ACO_Spending_on_Spending_Results.doc, replace ctitle("T-1") dec(5) nonotes title(Table X. Per Capita Spending on Lagged Per Capita Spending) addnote(NOTE--Table reports regression coefficients with robust standard errors in parentheses. The dependent variable in each regression is per capita spending at the ACO-year level., ***p<0.01 **p<0.05 *p<0.1)

xtreg per_cap_exp l2.per_cap_exp, r

outreg2 using output/ACO_Spending_on_Spending_Results.doc, append ctitle("T-2") 

xtreg per_cap_exp l3.per_cap_exp, r

outreg2 using output/ACO_Spending_on_Spending_Results.doc, append ctitle("T-3") 


*Growth on Spending

xtreg spend_growth l.per_cap_exp, r

outreg2 using output/ACO_Growth_on_Spending_Results.doc, replace ctitle("T-1") dec(5) nonotes title(Table X. Growth of Per Capita Spending on Lagged Per Capita Spending) addnote(NOTE--Table reports regression coefficients with robust standard errors in parentheses. The dependent variable in each regression is the growth in per capita spending at the ACO-year level., ***p<0.01 **p<0.05 *p<0.1)

xtreg spend_growth l2.per_cap_exp, r

outreg2 using output/ACO_Growth_on_Spending_Results.doc, append ctitle("T-2")

xtreg spend_growth l3.per_cap_exp, r

outreg2 using output/ACO_Growth_on_Spending_Results.doc, append ctitle("T-3")


*Growth on Growth

xtreg spend_growth l.spend_growth, r

outreg2 using Output/ACO_Growth_on_Growth_Results.doc, replace ctitle("T-1") dec(5) title(Table X. Per Capita Spending Growth on Lagged Per Capita Spending Growth) nonotes addnote(NOTE--Table reports regression coefficients with robust standard errors in parentheses. The dependent variable in each regression is the 3 year growth rate in an ACO's per capita spending at the ACO-year level., ***p<0.01 **p<0.05 *p<0.1)

xtreg spend_growth l2.spend_growth, r

outreg2 using output/ACO_Growth_on_Growth_Results.doc, append ctitle("T-2")

*Figures
twoway (scatter spend_growth per_cap_exp_l1, mcolor(%50)) (lfit spend_growth per_cap_exp_l1), ytitle(Per Capita Spending Growth (%)) xtitle(Lagged Per Capita Spending ($)) legend(off)

twoway (scatter spend_growth spend_growth_l1, mcolor(%50)) (lfit spend_growth spend_growth_l1), ytitle(Per Capita Spending Growth (%)) xtitle(Lagged Per Capita Spending Growth (%)) legend(off)

