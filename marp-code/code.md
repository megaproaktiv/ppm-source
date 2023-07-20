---
marp: true
paginate: true
theme: code
size: 16:9
title: marp-markdown
emoji: true
headingDivider: 1
---
# Bash

```bash
function iecho() {
  if [[ $VERBOSE == true ]]; then
    echo "$@"
  fi
}
```

# C++

```cpp
    //TODO(user): Change the bucket location constraint enum to your target Region.
    if (clientConfig.region != "us-east-1") {
        Aws::S3::Model::CreateBucketConfiguration createBucketConfig;
        createBucketConfig.SetLocationConstraint(
                Aws::S3::Model::BucketLocationConstraintMapper::GetBucketLocationConstraintForName(
                        clientConfig.region));
        request.SetCreateBucketConfiguration(createBucketConfig);
    }

```

# C# 

```cs
  public static async Task<bool> CreateBucketAsync(IAmazonS3 client, string bucketName)
        {
            try
            {
                var request = new PutBucketRequest
                {
                    BucketName = bucketName,
                    UseClientRegion = true,
                };

                var response = await client.PutBucketAsync(request);
                return response.HttpStatusCode == System.Net.HttpStatusCode.OK;
            }
            catch (AmazonS3Exception ex)
            {
                Console.WriteLine($"Error creating bucket: '{ex.Message}'");
                return false;
            }
        }
```

# GO

```go
func (basics BucketBasics) CreateBucket(name string, region string) error {
	_, err := basics.S3Client.CreateBucket(context.TODO(), &s3.CreateBucketInput{
		Bucket: aws.String(name),
		CreateBucketConfiguration: &types.CreateBucketConfiguration{
			LocationConstraint: types.BucketLocationConstraint(region),
		},
	})
	if err != nil {
		log.Printf("Couldn't create bucket %v in Region %v. Here's why: %v\n",
			name, region, err)
	}
	return err
}
```

# JavaScript


```js
export const main = async () => {
  const command = new CreateBucketCommand({
    // The name of the bucket. Bucket names are unique and have several other constraints.
    // See https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
    Bucket: "bucket-name",
  });

  try {
    const { Location } = await client.send(command);
    console.log(`Bucket created with location ${Location}`);
  } catch (err) {
    console.error(err);
  }
};
```

# Python :snake:
Here is your first python code:


```python
class BucketWrapper:
    def create(self, region_override=None):
        if region_override is not None:
            region = region_override
        else:
            region = self.bucket.meta.client.meta.region_name

```


<!-- #end -->
