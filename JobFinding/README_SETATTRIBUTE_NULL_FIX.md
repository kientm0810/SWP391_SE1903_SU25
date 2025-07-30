# Fix for "Cannot call setAttribute with a null name" Error

## Problem Description
The error "Cannot call setAttribute with a null name" occurs when trying to set a request attribute with a null attribute name.

## Root Cause
In `PostController.java` at line 120, the code was calling:
```java
request.setAttribute(view, page);
```

Where `view` is obtained from:
```java
String view = request.getParameter("view");
```

If the "view" parameter is not provided in the request, `view` becomes `null`, causing the error when calling `setAttribute`.

## Solution Applied
Added a null check before calling `setAttribute`:

**Before:**
```java
request.setAttribute("keyword", keyword);
request.setAttribute("jobType", jobType);
request.setAttribute("location", location);
request.setAttribute(view, page);  // This could fail if view is null
```

**After:**
```java
request.setAttribute("keyword", keyword);
request.setAttribute("jobType", jobType);
request.setAttribute("location", location);
if (view != null) {
    request.setAttribute(view, page);
}
```

## Prevention Guidelines
To prevent similar issues in the future:

1. **Always check for null before using dynamic attribute names:**
   ```java
   String attrName = request.getParameter("someParam");
   if (attrName != null && !attrName.trim().isEmpty()) {
       request.setAttribute(attrName, value);
   }
   ```

2. **Use string literals for attribute names when possible:**
   ```java
   // Good - safe
   request.setAttribute("user", user);
   
   // Risky - needs null check
   request.setAttribute(dynamicName, value);
   ```

3. **Validate parameters before using them as attribute names:**
   ```java
   String paramName = request.getParameter("paramName");
   if (paramName == null || paramName.trim().isEmpty()) {
       // Handle missing parameter
       paramName = "defaultName";
   }
   request.setAttribute(paramName, value);
   ```

## Files Modified
- `JobFinding/src/java/controllers/PostController.java` - Added null check for view parameter

## Testing
To test the fix:
1. Access `/post` without the "view" parameter
2. The page should load without errors
3. Access `/post?view=someValue` - should work as before

## Related Issues
This pattern should be checked in other controllers if they use dynamic attribute names from request parameters. 