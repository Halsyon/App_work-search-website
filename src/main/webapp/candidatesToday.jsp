<%-- библиотекой JSTL. Напомню, что Scriplet - это Java код написанный в JSP. Чтобы писать код в едином стиле используют библиотеку тегов JSTL. --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.worksearch.website.model.Candidate" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.worksearch.website.store.PsqlStore" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous"></script>
    <%--Иконки редактирования (квадрат с карандашом) --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <title>Работа мечты</title>
</head>
<body>
<%
    String id = request.getParameter("id");
    Candidate candidate = new Candidate(0, "");
    if (id != null) {
        candidate = PsqlStore.instOf().findByIdCandidate(Integer.parseInt(id));
    }
%>
<div class="container pt-3">
    <div class="row">
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/posts.do">Вакансии</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/candidates.do">Кандидаты</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/post/edit.jsp">Добавить вакансию</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/candidate/edit.jsp">Добавить
                    кандидата</a>
            </li>
            <c:if test="${user == null}">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/login/login.jsp">Войти</a>
                </li>
            </c:if>
            <c:if test="${user != null}">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/logout.do">
                        <c:out value="${user.name}"/> | Выйти</a>
                </li>
            </c:if>
        </ul>
    </div>
    <div class="row">
        <div class="card" style="width: 100%">
            <div class="card-header">
                <h1 align="center">Candidates</h1>
            </div>
            <div class="card-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">Name</th>
                        <th scope="col">Description</th>
                        <th scope="col">City</th>
                        <th scope="col">Date create</th>
                        <th scope="col">Edit/Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%-- загрузка КандидатСервлеет, doGet - от него приходит перечень Кандидатов--%>
                    <c:forEach items="${candidates}" var="candidate">
                        <tr>
                            <td> <%-- Передали в ДонлоадСервлет по ключу name - id Кандидата, doGet вернул фото из папки с таким номером--%>
                                <img src="<c:url value='/download?name=${candidate.id}'/>" width="50px" height="50px"/>
                            </td>
                            <td><c:out value="${candidate.name}"/></td><%-- c:out value="post.name"- Вывод значения post. --%>
                            <td><c:out value="${candidate.position}"/></td>
                            <td><c:out value="${candidate.cityId}"/></td>
                            <td><c:out value="${candidate.created}"/></td>
                            <td>                <%--добавить иконку редактирования в таблицу и ссылку на страницу edit. --%>
                                <a href="<c:url value='/candidate/edit.jsp?id=${candidate.id}'/>">
                                    <em class="fa fa-edit mr-3"></em>
                                </a>
                                <br>
                                <a href="<c:url value='/upload.jsp?id=${candidate.id}'/>">
                                    Edit photo</a>
                                <br>
                                <form style="display: inline" action="<c:url value='/delete.do?id=${candidate.id}'/>"
                                      method="post">
                                    <button>Delete candidate</button>
                                </form>

                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>

