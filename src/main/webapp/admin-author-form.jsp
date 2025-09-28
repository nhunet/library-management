<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Author Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <div class="container">
                <a href="<%=request.getContextPath()%>/list" class="navbar-brand">Library Management</a>
            </div>
        </nav>
    </header>
    
    <div class="container col-md-5 mt-4">
        <div class="card">
            <div class="card-body">
                <c:if test="${author != null}">
                    <form action="updateAuthor" method="post">
                </c:if>
                <c:if test="${author == null}">
                    <form action="insertAuthor" method="post">
                </c:if>

                <caption>
                    <h2>
                        <c:if test="${author != null}">
                            Edit Author
                        </c:if>
                        <c:if test="${author == null}">
                            Add New Author
                        </c:if>
                    </h2>
                </caption>

                <c:if test="${author != null}">
                    <input type="hidden" name="id" value="<c:out value='${author.id}' />" />
                </c:if>

                <div class="form-group">
                    <label>Author Name</label>
                    <input type="text" name="name" class="form-control" 
                        value="<c:out value='${author.name}' />" required>
                </div>

                <div class="form-group">
                    <label>Birth Date</label>
                    <input type="date" name="birthDate" class="form-control" 
                        value="<c:out value='${author.birthDate}' />">
                </div>

                <div class="form-group">
                    <label>Nationality</label>
                    <input type="text" name="nationality" class="form-control" 
                        value="<c:out value='${author.nationality}' />">
                </div>

                <button type="submit" class="btn btn-success">Save</button>
                <a href="<%=request.getContextPath()%>/authorList" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>