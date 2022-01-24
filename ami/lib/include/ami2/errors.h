#ifndef _AMI2_ERRORS_H_
#define _AMI2_ERRORS_H_

#ifdef __cplusplus
extern "C" {
#endif

#define AMIERR_UNKNOWN 0
#define AMIERR_NO_VERSION_SET 1
#define AMIERR_NOT_ASSIGNED_TO_VAR 2
  
static const char *ami2_error_desc[] = {
  "Unknown Error",
  "Missing ami_version. Simply add 'ami_version 2' as first line",
  "Assignment not set to a variable",
  "Cannot have an action block in another action block!",
};
  
#ifdef __cplusplus
}
#endif

#endif // _AMI2_ERRORS_H_
