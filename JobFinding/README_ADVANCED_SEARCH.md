# Advanced Job Search Feature - JobFinding

## 📋 Overview
The Advanced Job Search feature provides comprehensive job search capabilities with multiple filters, search history, saved jobs, and intelligent suggestions.

## 🏗️ Architecture

### Database Tables
- **Job_Searches**: Stores search history and saved searches
- **Saved_Jobs**: Stores user's saved job listings
- **Search_Suggestions**: Stores popular search terms and suggestions
- **Posts**: Main job listings table with all searchable fields

### Core Components

#### 1. Models
- `AdvancedSearchCriteria.java` - Encapsulates all search parameters
- `JobSearch.java` - Represents search history records
- `SavedJob.java` - Represents saved job records

#### 2. Data Access Objects (DAOs)
- `PostsDAO.java` - Advanced search queries with dynamic SQL
- `JobSearchDAO.java` - Search history management
- `SearchSuggestionDAO.java` - Search suggestions and popular terms
- `SavedJobDAO.java` - Saved jobs management

#### 3. Controllers
- `AdvancedSearchController.java` - Main search request handler
- `SaveJobController.java` - AJAX endpoint for saving jobs

#### 4. Views
- `advanced-search.jsp` - Complete search interface
- `advanced-search.css` - Responsive styling

## 🚀 Features

### 1. Advanced Search Filters
- **Basic Search**: Keyword, location, industry
- **Job Details**: Job type, experience level, work type
- **Salary Range**: Min/max salary filtering
- **Company & Benefits**: Company size, benefits
- **Skills & Requirements**: Skills, education, language
- **Sorting**: Multiple sort options (date, salary, title, company)

### 2. Search History
- Automatic saving of search criteria
- Search statistics and analytics
- Saved searches for quick access
- Search frequency tracking

### 3. Intelligent Suggestions
- Popular keywords based on search frequency
- Location suggestions
- Industry suggestions
- Recent search history

### 4. Saved Jobs
- One-click job saving
- Saved jobs management
- AJAX integration for seamless UX

### 5. Responsive Design
- Mobile-friendly interface
- Collapsible filter sections
- Smooth animations and transitions
- Accessibility features

## 🔧 Technical Implementation

### Dynamic SQL Query Building
```java
public List<Posts> advancedSearch(AdvancedSearchCriteria criteria) {
    StringBuilder sql = new StringBuilder();
    List<Object> params = new ArrayList<>();
    
    sql.append("SELECT * FROM Posts WHERE post_type = 'post' AND status = 'active' AND deleted_at IS NULL");
    
    // Add filters dynamically based on criteria
    if (criteria.getKeyword() != null && !criteria.getKeyword().trim().isEmpty()) {
        sql.append(" AND (title LIKE ? OR company_name LIKE ? OR job_description LIKE ? OR keywords LIKE ?)");
        String searchPattern = "%" + criteria.getKeyword().trim() + "%";
        params.add(searchPattern);
        params.add(searchPattern);
        params.add(searchPattern);
        params.add(searchPattern);
    }
    
    // Add more filters...
    
    // Sorting and pagination
    sql.append(" ORDER BY ").append(criteria.getSortBy()).append(" ").append(criteria.getSortOrder());
    sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
    
    return executeQuery(sql.toString(), params);
}
```

### AJAX Integration
```javascript
// Save job functionality
function saveJob(jobId) {
    fetch('save-job', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'jobId=' + jobId
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Đã lưu việc làm thành công!');
        } else {
            alert('Có lỗi xảy ra: ' + data.message);
        }
    });
}
```

### Search History Management
```java
private void saveSearchHistory(Integer jobSeekerId, AdvancedSearchCriteria criteria, int resultCount) {
    JobSearch jobSearch = new JobSearch();
    jobSearch.setJobSeekerId(jobSeekerId);
    jobSearch.setSearchType("advanced");
    jobSearch.setKeyword(criteria.getKeyword());
    jobSearch.setLocation(criteria.getLocation());
    // ... set other criteria
    jobSearch.setResultCount(resultCount);
    
    jobSearchDAO.saveJobSearch(jobSearch);
}
```

## 📱 User Interface

### Search Interface Features
- **Collapsible Filter Sections**: Organized filter categories
- **Real-time Suggestions**: Popular keywords and locations
- **Search Statistics**: Results count, search time, pagination
- **Responsive Design**: Works on all device sizes
- **Accessibility**: Screen reader friendly, keyboard navigation

### Filter Categories
1. **Basic Search**: Keyword, location, industry
2. **Job Details**: Job type, experience, work type
3. **Salary Range**: Min/max salary inputs
4. **Company & Benefits**: Company size, benefits
5. **Skills & Requirements**: Skills, education, language
6. **Sort Options**: Multiple sorting criteria

## 🔍 Search Capabilities

### Text Search
- **Title Search**: Job title matching
- **Company Search**: Company name matching
- **Description Search**: Job description content
- **Keywords Search**: Tagged keywords

### Filter Combinations
- **Location + Industry**: Geographic and sector filtering
- **Salary + Experience**: Compensation and skill level
- **Company Size + Benefits**: Organization characteristics
- **Skills + Education**: Technical and educational requirements

### Advanced Features
- **Fuzzy Matching**: Partial text matching
- **Case Insensitive**: Search regardless of case
- **Multi-field Search**: Search across multiple fields
- **Parameterized Queries**: SQL injection prevention

## 📊 Analytics & Insights

### Search Analytics
- **Search Frequency**: Track popular search terms
- **User Behavior**: Analyze search patterns
- **Performance Metrics**: Search time, result counts
- **Trend Analysis**: Popular industries, locations, skills

### Data Collection
- **Search History**: User's search patterns
- **Saved Searches**: Frequently used search criteria
- **Popular Terms**: System-wide popular searches
- **Performance Data**: Search response times

## 🛡️ Security Features

### Input Validation
- **Parameter Sanitization**: Clean user inputs
- **SQL Injection Prevention**: Parameterized queries
- **XSS Protection**: Output encoding
- **Access Control**: User authentication checks

### Data Protection
- **User Privacy**: Secure search history storage
- **Session Management**: Proper user session handling
- **Error Handling**: Graceful error management
- **Logging**: Comprehensive error logging

## 🚀 Performance Optimizations

### Database Optimization
- **Indexed Fields**: Optimized database indexes
- **Query Optimization**: Efficient SQL queries
- **Connection Pooling**: Database connection management
- **Caching**: Search result caching

### Frontend Optimization
- **Lazy Loading**: Progressive content loading
- **Minified Assets**: Optimized CSS and JS
- **CDN Integration**: Fast asset delivery
- **Responsive Images**: Optimized image loading

## 📈 Future Enhancements

### Planned Features
- **AI-Powered Suggestions**: Machine learning recommendations
- **Advanced Analytics**: Detailed search insights
- **Email Alerts**: Job matching notifications
- **Mobile App**: Native mobile application
- **API Integration**: Third-party job board integration

### Technical Improvements
- **Elasticsearch Integration**: Advanced search engine
- **Redis Caching**: High-performance caching
- **Microservices**: Scalable architecture
- **Real-time Updates**: Live job updates

## 🛠️ Installation & Setup

### Prerequisites
- Java 8 or higher
- SQL Server 2016 or higher
- Apache Tomcat 9 or higher
- Maven (for dependency management)

### Database Setup
1. Execute the database script: `database/script (1).sql`
2. Configure database connection in `DBContext.java`
3. Verify all tables are created successfully

### Application Setup
1. Clone the repository
2. Configure database connection
3. Build the project: `mvn clean install`
4. Deploy to Tomcat server
5. Access the application: `http://localhost:8080/JobFinding`

### Configuration
- Database connection settings in `DBContext.java`
- Email settings for notifications
- File upload paths for CVs and images
- Search pagination settings

## 📝 Usage Guide

### For Job Seekers
1. **Access Advanced Search**: Navigate to `/advanced-search`
2. **Set Search Criteria**: Use filters to narrow down jobs
3. **Save Searches**: Click "Lưu tìm kiếm" to save criteria
4. **Save Jobs**: Click bookmark icon to save interesting jobs
5. **View History**: Access search history and saved jobs

### For Developers
1. **Extend Filters**: Add new search criteria in `AdvancedSearchCriteria.java`
2. **Customize UI**: Modify `advanced-search.jsp` for interface changes
3. **Add Analytics**: Extend search tracking in `JobSearchDAO.java`
4. **Optimize Queries**: Improve performance in `PostsDAO.java`

## 🐛 Troubleshooting

### Common Issues
- **Database Connection**: Check `DBContext.java` configuration
- **Search Not Working**: Verify database indexes are created
- **AJAX Errors**: Check browser console for JavaScript errors
- **Performance Issues**: Monitor database query performance

### Debug Mode
- Enable debug logging in application
- Check database query execution plans
- Monitor application server logs
- Use browser developer tools for frontend issues

## 📞 Support

For technical support or feature requests:
- Create an issue in the project repository
- Contact the development team
- Check the project documentation
- Review the troubleshooting guide

---

**Version**: 1.0  
**Last Updated**: January 2025  
**Maintainer**: JobFinding Development Team 