*ACO-Year File Analysis
*Andres de Loera-Brust

clear all
cd "C:/Users/Andres/Documents/Harvard/Senior Year/HCP/aco_time_series"

*Install Outreg commands
ssc install outreg
ssc install outreg2

*Import the dataset
import delim using "aco_year_master_file.csv"

*Edit the data
gen quality_score = real(qual_score)
drop qual_score

*Label the data
lab var aco_num "ACO ID"
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
lab var final_share_rate "Shared Savings Rate"
lab var service_length "Days of ACO Operation"
lab var year "Year"
lab var entered "Entered MSSP This Year"
lab var exit "Exited MSSP This Year"
lab var counties "Number of Counties"
lab var quality_score "Quality Score"


