package test

import (
	"fmt"
	"math/rand"
	"strconv"
	"strings"
	"testing"

	"github.com/aws/aws-sdk-go/service/s3/s3manager"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAwsS3(t *testing.T) {
	t.Parallel()

	expectedName := "challenge-s3-jfr992"

	awsRegion := "us-east-2"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../"})

	terraform.Init(t, terraformOptions)

	//check that s3-id output is s3 bucket name
	bucketID := terraform.Output(t, terraformOptions, "s3-id")
	assert.Equal(t, expectedName, bucketID)
	//check if bucket exists
	aws.AssertS3BucketExists(t, awsRegion, bucketID)
	randnumber := rand.Int()
	rstring := strconv.Itoa(randnumber)
	key := fmt.Sprintf("%s%s", rstring, ".txt")
	body := strings.NewReader("test")
	params := &s3manager.UploadInput{
		Bucket: &bucketID,
		Key:    &key,
		Body:   body,
	}
	uploader := aws.NewS3Uploader(t, awsRegion)

	uploader.Upload(params)

}
