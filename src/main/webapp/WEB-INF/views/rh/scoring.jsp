<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Scoring des employés</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .note {
            font-weight: bold;
            color: #ff9800;
        }

        .btn-retour {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .btn-retour:hover {
            background-color: #5a6268;
        }

        .container {
            max-width: 900px;
            margin: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>📊 Rapport d’évaluation des employés</h2>

    <table>
        <thead>
            <tr>
                <th>Employé</th>
                <th>Mois</th>
                <th>Année</th>
                <th>Note</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="e" items="${evaluations}">
                <tr>
                    <td>${e.employe.nom} ${e.employe.prenom}</td>
                    <td>${e.mois}</td>
                    <td>${e.annee}</td>
                    <td class="note">${e.note} ⭐</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Bouton retour -->
    <a href="${pageContext.request.contextPath}/rh/employe" class="btn-retour">⬅ Retour à la gestion RH</a>
</div>
</body>
</html>
