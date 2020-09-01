# 개요
- AccuInsightPlus 를 Azure 클라우드 환경에 설치하기 위한 스크립트 

# 방안
- 디렉토리별 작업 단위가 이루어 지며 독립적으로 빌드/테스트가 이루어질 수 있어야 합니다.

# 보안/인증정보 관련 주의사항
- 소스에는 최대한 인증정보를 저장하지 않는다.
- Azure에서는 Teraform Status 저장을 위한 ftstate 파일 저장을 위해서는 스토리지 어카운트 인증정보를 코드상에 저장해야 하는데, 이건 예외로 함. 

# 초기 크리덴셜 확보하기
- 아래 명령어 실행 
- `Owner` 권한의 계정으로 관리콘솔에 로긴 후 Cloud Shell을 연다.
- 아래 커맨드를 수행해서 `Terraform-Mungi` 이름의 RBAC을 하나 만들고, 출력되는 4가지 환경 변수 정보를 확보한다. (이름은 변경)
``` bash
export ARM_SUBSCRIPTION_ID=$(az account list | jq -r '.[].id')
export ARM_TENANT_ID=$(az account list | jq -r '.[].tenantId')

TF_RBAC_CRED=$(az ad sp create-for-rbac -n "Terraform-Mungi" --role="Contributor" --scopes="/subscriptions/${ARM_SUBSCRIPTION_ID}")

export ARM_CLIENT_ID=$(echo $TF_RBAC_CRED | jq -r '.appId')
export ARM_CLIENT_SECRET=$(echo $TF_RBAC_CRED | jq -r '.password')

echo "export ARM_CLIENT_ID=\"$ARM_CLIENT_ID\"
export ARM_CLIENT_SECRET=\"$ARM_CLIENT_SECRET\"
export ARM_SUBSCRIPTION_ID=\"$ARM_SUBSCRIPTION_ID\"
export ARM_TENANT_ID=\"$ARM_TENANT_ID\""
```

## Azure Terraform 참고 문서
- https://docs.microsoft.com/ko-kr/azure/terraform/

## Terraform 인증
- Terraform 인증은 아래 4가지 환경 변수를 셋팅해서 사용

``` bash
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
```

- 참고 URL : https://docs.microsoft.com/ko-kr/azure/terraform/terraform-install-configure

## az cli 인증
``` bash
az login  --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
```

# 프로비저닝 프로세스
1. 인증을 위한 shell 만들기
- `# 초기 크리덴셜 확보하기을 실행해서 인증에 필요한 정보를 획득한다.`
- 인증정보를 프로젝트 디렉터리 root 에 아래와 같은 형태로 저장한다.
- vi auth-azure-cloudarch.sh
``` bash
# 2020.08.25 m365 마이그레이션 이후에 변경된 인증정보
export ARM_CLIENT_ID="9e3476c9-xxxxx-4deb-a1fd-xxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxx~EI-e1IOBucVd8V5pYUOX~GJWSS"
export ARM_SUBSCRIPTION_ID="e892c402-xxxxx-xxxx-xxxx-375dd0865702"
export ARM_TENANT_ID="36a31c78-60b6-xxxxx-8f11-dcf0a0c54cd0"

# AKS 생성을 위해서 별도로 인증정보를 저장해야함
export TF_VAR_client_id="9e3476c9-xxxxxxxxxxx-4deb-a1fd-0bb9902297ba"
export TF_VAR_client_secret="xxxxx~xxxxxx-e1IOBucVd8V5pYUOX~GJWSS"
```

2. tfstate 저장을 위한 `스토리지 어카운트` 생성 
- tfstate 저장을 위한 `01tfstat-storageaccount` 실행

3. 실행하고 나온 결과값을 각각의 디렉터리의 modify-backend.tf 파일의 정보 수정 필요
``` bash
    storage_account_name  = "tfstte2c1238d3" # <-- 수정>
    container_name        = "tfstte2c1238d3-tfstat1"  # <-- 수정>
    access_key            = "bnBV5LOABgr21ggjKSx1w4+gsadjksalhdlasdfDWK18cOAba8yG5rOpRUtAADQzPdAnRN5E35/oLW/X14lBl9oe4er5jvbuQ=="  # <-- 수정>
    key                   = "accu-hdinsight-rg"  # <-- 수정 >
```

4. 각각의 디렉터리에서 실행
- vi auth-azure-cloudarch.sh
``` bash
01.init.sh
02.plan.sh
03.apply.sh
그리고 삭제할때는 04.destroy.sh 를 실행하고 yes 를 눌러줘야 함. -force 옵션을 주면 자동 삭제도 가능한데, 혹시 몰라서 옵션 적용은 하지 않음. 
```