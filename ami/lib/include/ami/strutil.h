#ifndef _AMI_STRUTIL_H_
#define _AMI_STRUTIL_H_

#ifdef __cplusplus
extern "C" {
#endif

char *ami_strutil_replace_all_substrings(const char *haystack, const char *needle, const char *replacement);
char *ami_strutil_make_replacevar(const char *var);
  
#ifdef __cplusplus
}
#endif

#endif // _AMI_STRUTIL_H_
