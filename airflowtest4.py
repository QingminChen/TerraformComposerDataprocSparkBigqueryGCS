from datetime import datetime,timedelta

import os

from airflow import DAG
# from airflow.operators.bash_operator import BashOperator
from airflow.operators import bash_operator
from airflow.contrib.operators import dataproc_operator

# GCP_PROJECT = os.environ["GCP_PROJECT_ID"]
# DATAPROC_BUCKET = os.environ['DATAPROC_BUCKET']
# INPUT_BUCKET = os.environ['INPUT_BUCKET']
# OUTPUT_BUCKET = os.environ['OUTPUT_BUCKET']
# ARCHIVE_BUCKET = os.environ['ARCHIVE_BUCKET']
# DATAPROC_REGION = os.environ['DATAPROC_REGION']
# GKE_CLUSTER_NAME = os.environ['GKE_NAME_CLUSTER']


    # create_cluster = DataprocClusterCreateOperator(
    #     # ds_nodash is an airflow macro for "[Execution] Date string no dashes"
    #     # in YYYYMMDD format. See docs https://airflow.apache.org/code.html?highlight=macros#macros
    #     # storage_bucket=Variable.get('dataproc_bucket'),
    #     #zone=Variable.get('gce_zone'),
    #
	# 	task_id="create_dataproc_cluster",
	# 	num_workers=2,
	# 	image_version="1.4-debian9",
	# 	project_id="dataprod-cluster-testing-1",
	# 	cluster_name="cluster-test-1",
	# 	zone="us-central1-f",
	# 	network_uri="projects/dataprod-cluster-testing-1/regions/us-central1/networks/default",
	# 	subnetwork_uri="projects/dataprod-cluster-testing-1/regions/us-central1/subnetworks/default",
	# 	storage_bucket="gs://composor-staging-us-central1-temp",
	# 	num_masters=1,
	# 	master_machine_type='n1-standard-4',
	# 	master_disk_type='pd-standard',
	# 	master_disk_size=15,
	# 	worker_machine_type='n1-standard-2',
	# 	worker_disk_type='pd-standard',
	# 	worker_disk_size=15,
	# 	region='us-central1',
	# 	service_account="742690957765-compute@developer.gserviceaccount.com",
	# 	service_account_scopes=["https://www.googleapis.com/auth/cloud-platform"]
	# )

    # submit_sparksql_bq_gcs_batch = DataProcSparkOperator(
	# 	task_id="run_sparksql_bq_gcs_batch",
	# 	# dataproc_spark_jars="gs://sparksql_bq_gcs_batch_test/sparkSQL-BQ-GS-1.0-SNAPSHOT.jar",
	# 	main_class="com.qingmin.testProject.sparkSQLBQGSExample",
	# 	job_name="sparksql_bq_gs",
	# 	cluster_name="cluster-test-1",
	# 	# arguments=['gs://igu_resources/code/config.properties', 'pa', 'gs://igu_resources/'],
	# 	region='us-central1',
	# 	service_account='742690957765-compute@developer.gserviceaccount.com',
	#     main_jar = "gs://sparksql_bq_gcs_batch_test/sparkSQL-BQ-GS-1.0-SNAPSHOT.jar",
	# 	dataproc_spark_properties = [{"spark.master","yarn"},{"spark.submit.deployMode","cluster"},{"spark.shuffle.service.enabled":"false"},{"spark.driver.memory","3g"},{"spark.executor.cores":"2"},{"spark.executor.instances":"2"},{"spark.executor.memory":"3g"},{"spark.allocationDynamic.enabled":"false"},{"spark.jars.packages":"org.apache.spark:spark-avro_2.11:2.4.5"}]
	# )

# IMAGE_VERSION = '1.4.27-beta'
# DATAPROC_CLUSTER_NAME = '-'.join(['spark-k8s', datetime.now().strftime('%y%m%d%H%m')])
# JOB_NAME = '-'.join(['date-job', datetime.now().strftime('%y%m%d%H%m')])
# JAR_BUCKET = f'gs://{DATAPROC_BUCKET}/date_converter_2.12-0.1.0-SNAPSHOT.jar'
# MAIN_CLASS = 'adaltas.DateApplication'

# gcloud dataproc jobs submit spark --cluster=cluster-test-1 --region=us-central1 --properties=['spark.master'='yarn','spark.submit.deployMode'='cluster','spark.shuffle.service.enabled'='false','spark.driver.memory=3g','spark.executor.cores'=2,'spark.executor.instances'=2,'spark.executor.memory'='3g','spark.allocationDynamic.enabled'='false','spark.jars.packages'='org.apache.spark:spark-avro_2.11:2.4.5'] --class=com.qingmin.testProject.sparkSQLBQGSExample --jars=gs://sparksql_bq_gcs_batch_test/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar

dataproc_create_job = f'''
    gcloud dataproc clusters create cluster-test-1 --region=us-central1 --project=dataprod-cluster-testing-1 --num-workers=2 --image-version='1.4-debian9' --zone=us-central1-f \
    --bucket=dataproc_cluster_temp_by_composer --num-masters=1 --master-machine-type=n1-standard-4 --master-boot-disk-type=pd-standard --master-boot-disk-size=15 --worker-machine-type=n1-standard-2 \
    --worker-boot-disk-type=pd-standard --worker-boot-disk-size=15 --service-account='742690957765-compute@developer.gserviceaccount.com' --scopes=cloud-platform
    '''

# dataproc_launch_job = f'''
#     gcloud dataproc jobs submit spark --cluster=cluster-test-1 --region=us-central1 --properties='spark.master'='yarn','spark.submit.deployMode'='cluster','spark.shuffle.service.enabled'='true','spark.driver.memory=3g','spark.executor.cores'=2,'spark.executor.instances'=2,'spark.executor.memory'='3g','spark.allocationDynamic.enabled'='false','spark.jars.packages'='org.apache.spark:spark-avro_2.11:2.4.5' --class=com.qingmin.testProject.sparkSQLBQGSExample --jars=gs://sparksql_bq_gcs_batch_test/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar
#     '''
dataproc_launch_job = f'''
    gcloud dataproc jobs submit spark --cluster=cluster-test-1 --region=us-central1 --properties='spark.master'='yarn','spark.submit.deployMode'='cluster','spark.shuffle.service.enabled'='true','spark.driver.memory=3g','spark.executor.cores'=2,'spark.executor.instances'=2,'spark.executor.memory'='3g','spark.allocationDynamic.enabled'='false','spark.jars.packages'='org.apache.spark:spark-avro_2.11:2.4.5' --class=com.qingmin.testProject.sparkSQLBQGSExample --jars=gs://integrate-source-code/codes/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar
    '''

# upload_json_file_dataproc_cluster_master_copmmand = f'''
#     gcloud dataproc jobs submit spark --cluster=cluster-test-1 --region=us-central1 --properties='spark.master'='yarn','spark.submit.deployMode'='cluster','spark.shuffle.service.enabled'='true','spark.driver.memory=3g','spark.executor.cores'=2,'spark.executor.instances'=2,'spark.executor.memory'='3g','spark.allocationDynamic.enabled'='false','spark.jars.packages'='org.apache.spark:spark-avro_2.11:2.4.5' --class=com.qingmin.testProject.sparkSQLBQGSExample --jars=gs://sparksql_bq_gcs_batch_test/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar
#     '''
#
# upload_json_file_dataproc_cluster_worker_1_copmmand = f'''
#     gcloud dataproc jobs submit spark --cluster=cluster-test-1 --region=us-central1 --properties='spark.master'='yarn','spark.submit.deployMode'='cluster','spark.shuffle.service.enabled'='true','spark.driver.memory=3g','spark.executor.cores'=2,'spark.executor.instances'=2,'spark.executor.memory'='3g','spark.allocationDynamic.enabled'='false','spark.jars.packages'='org.apache.spark:spark-avro_2.11:2.4.5' --class=com.qingmin.testProject.sparkSQLBQGSExample --jars=gs://sparksql_bq_gcs_batch_test/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar
#     '''
#
# upload_json_file_dataproc_cluster_worker_2_copmmand = f'''
#     gcloud dataproc jobs submit spark --cluster=cluster-test-1 --region=us-central1 --properties='spark.master'='yarn','spark.submit.deployMode'='cluster','spark.shuffle.service.enabled'='true','spark.driver.memory=3g','spark.executor.cores'=2,'spark.executor.instances'=2,'spark.executor.memory'='3g','spark.allocationDynamic.enabled'='false','spark.jars.packages'='org.apache.spark:spark-avro_2.11:2.4.5' --class=com.qingmin.testProject.sparkSQLBQGSExample --jars=gs://sparksql_bq_gcs_batch_test/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar
#     '''
# gcloud compute scp --project="dataprod-cluster-testing-1" --zone="us-central1-f" /home/testinggcpuser/AllServicesKey.json cluster-test-1-m:/home/testinggcpuser
# gcloud compute scp --project="dataprod-cluster-testing-1" --zone="us-central1-f" /home/testinggcpuser/AllServicesKey.json cluster-test-1-w-0:/home/testinggcpuser
# gcloud compute scp --project="dataprod-cluster-testing-1" --zone="us-central1-f" /home/testinggcpuser/AllServicesKey.json cluster-test-1-w-1:/home/testinggcpuser


default_args = {
    'depends_on_past': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=1),
    'project_id': "dataprod-cluster-testing-1",
    'start_date': datetime.now() - timedelta(days=1),
    'owner': 'Bunny'+datetime.now().strftime("%Y-%m-%d_%H-%M-%S_%f")
}


with DAG(
        # dag_id='run_sparksql_bq_gcs',
        dag_id='new_one',
        max_active_runs=2,
        schedule_interval=timedelta(days=1),
        # start_date=datetime(2000, 5, 4),
        default_args=default_args,
        catchup=False) as dag:

    # gsutil iam ch serviceAccount:dataflowservicetestaccount@pubsub-test-project-16951.iam.gserviceaccount.com:objectAdmin,admin gs://composor-staging-us-central1-temp
    # configure_bucket_permission = bash_operator.BashOperator(
    #     task_id='configure_dataproc_bucket_permission_for_outside_serviceAccount',
    #     bash_command=
    #     f'''
    #            gsutil iam ch serviceAccount:dataflowservicetestaccount@pubsub-test-project-16951.iam.gserviceaccount.com:objectAdmin,admin gs://dataproc_cluster_temp_by_composer
    #            sleep 5
    #     '''
    # )

    configure_bucket_permission = bash_operator.BashOperator(
        task_id='configure_dataproc_bucket_permission_for_outside_serviceAccount',
        bash_command=
        f'''
               gsutil iam ch serviceAccount:dataflowservicetestaccount@pubsub-test-project-16951.iam.gserviceaccount.com:objectAdmin,admin gs://dataproc_cluster_temp_by_terraform
               sleep 5
        '''
    )

    # init_cluster = bash_operator.BashOperator(
    #     task_id='create_dataproc_cluster',
    #     bash_command=dataproc_create_job,
    # )

    cluster_ready = bash_operator.BashOperator(
        task_id='verify_dataproc_cluster',
        bash_command=
        f'''
        flag=1;
        while [ $flag -eq '1' ];
        do
            echo 'working';
            gcloud dataproc clusters describe cluster-test-1 --region us-central1 | grep 'state: RUNNING' | wc -l | grep 1 > /dev/null;
            flag=$?;
            sleep 1;
        done
        '''
    )

    # # gsutil iam ch serviceAccount:dataflowservicetestaccount@pubsub-test-project-16951.iam.gserviceaccount.com:objectAdmin,admin gs://composor-staging-us-central1-temp
    # configure_bucket_permission = bash_operator.BashOperator(
    #     task_id='configure_dataproc_bucket_permission_for_outside_serviceAccount',
    #     bash_command=
    #     f'''
    #        gsutil iam ch serviceAccount:dataflowservicetestaccount@pubsub-test-project-16951.iam.gserviceaccount.com:objectAdmin,admin gs://dataproc_cluster_temp_by_composer
    #        sleep 5
    #     '''
    # )

    run_job = bash_operator.BashOperator(
        task_id='run_job',
        bash_command=dataproc_launch_job
    )

    # delete_cluster = bash_operator.BashOperator(  #it can work
    #     task_id='delete_dataproc_cluster',
    #     bash_command=f'gcloud dataproc clusters delete cluster-test-1 --region=us-central1'
    # )


    # delete_dataproc_cluster = dataproc_operator.DataprocClusterDeleteOperator(      #it can work
    #     project_id='dataprod-cluster-testing-1',
    #     task_id='delete_dataproc_cluster',
    #     cluster_name='cluster-test-1',
    #     region='us-central1',
    #     dag=dag
    # )

    # archive_data = BashOperator(
    #     task_id='archive_ingested_input_data',
    #     bash_command=f'gsutil mv -r gs://{INPUT_BUCKET}/* gs://{ARCHIVE_BUCKET}/'
    # )

    # init_cluster >> cluster_ready >> run_job >> delete_cluster >> archive_data
    # init_cluster >> cluster_ready >> run_job >> delete_cluster
    # cluster_ready >> run_job >> delete_cluster
    # run_job >> delete_cluster
    # delete_dataproc_cluster
    # init_cluster >> delete_dataproc_cluster
    # init_cluster >> cluster_ready >> run_job
    # init_cluster
    # configure_bucket_permission >> run_job
    # run_job

    # configure_bucket_permission >> init_cluster >> cluster_ready >> run_job >> delete_dataproc_cluster
    # configure_bucket_permission
    # configure_bucket_permission >> init_cluster >> cluster_ready >> run_job >> delete_dataproc_cluster
    # configure_bucket_permission >> cluster_ready >> run_job >> delete_dataproc_cluster
    configure_bucket_permission >> cluster_ready >> run_job