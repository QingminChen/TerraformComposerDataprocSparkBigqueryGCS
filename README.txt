# TerraformComposerDataprocSparkBigqueryGCS
We lack of the jar file called 'sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar' in the repo
https://github.com/QingminChen/TerraformComposerDataprocSparkBigqueryGCS.git
we should execute the command 'mvn package' in the repo https://github.com/QingminChen/SparkSQL-Batch-GS-BQ-Test.git
can get the jar file in the target/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar of project 'SparkSQL-Batch-GS-BQ-Test'
and put it into the root folder of project TerraformComposerDataprocSparkBigqueryGCS
Hierarchy of project will be looking like this:

TerraformComposerDataprocSparkBigqueryGCS
                         |-------------------------------------------AllServicesKey.json (pubsub read and writhe credential jsonfile)
                         |-------------------------------------------airflowtest4.py     (submit spark job to dataproc)
                         |-------------------------------------------dataproc_init.sh    (init dataproc cluster while download the AllServicesKey.json from GCS to all nodes in dataproc cluster)
                         |-------------------------------------------dataprod-cluster-testing-1-7444c4c90649.json (dataprod-cluster-testing-1 itself owns its own credential json file)
                         |-------------------------------------------main.tf             (main file of terraform)
                         |-------------------------------------------modules
                         |                                              |-------create_composer_cluster
                         |                                              |                    |----------------main.tf
                         |                                              |                    |----------------outputs.tf
                         |                                              |                    |----------------variables.tf
                         |                                              |
                         |                                              |-------create_dataproc_cluster
                         |                                              |                    |----------------main.tf
                         |                                              |                    |----------------outputs.tf
                         |                                              |                    |----------------variables.tf
                         |                                              |             
                         |                                              |-------dataproc_prequisition
                         |                                              |                    |----------------main.tf
                         |                                              |                    |----------------outputs.tf
                         |                                              |                    |----------------variables.tf
                         |                                              |
                         |                                              |-------deploy_dag_jobs
                         |                                              |                    |----------------main.tf
                         |                                              |                    |----------------outputs.tf
                         |                                              |                    |----------------variables.tf
                         |                                              
                         |-------------------------------------------sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar. (packaged from github repo project SparkSQL-Batch-GS-BQ-Test
 via command 'mvn package')
