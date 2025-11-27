<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Évaluation de ${employe.nom}</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f4f6f8;
      margin: 0;
      padding: 40px;
    }

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 30px;
    }

    form {
      max-width: 500px;
      margin: auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
      color: #555;
    }

    select {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    .etoiles {
      margin-top: 10px;
      text-align: center;
    }

    .etoiles i {
      font-size: 30px;
      color: gray;
      cursor: pointer;
      margin: 5px;
      transition: color 0.3s;
    }

    .etoiles i.active {
      color: gold;
    }

    button {
      margin-top: 25px;
      width: 100%;
      padding: 10px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
  <h2>Évaluation de ${employe.nom}</h2>

  <form action="${pageContext.request.contextPath}/rh/employe/evaluation/soumettre" method="post">
    <input type="hidden" name="id_employe" value="${employe.id}" />

    <label>Mois :</label>
    <select name="mois">
      <c:forEach var="m" items="${['Janvier','Février','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre']}">
        <option value="${m}">${m}</option>
      </c:forEach>
    </select>

    <label>Année :</label>
    <select name="annee">
      <c:forEach var="a" begin="2020" end="2030">
        <option value="${a}">${a}</option>
      </c:forEach>
    </select>

    <label>Note :</label>
    <div class="etoiles">
      <input type="hidden" name="note" id="note" value="0"/>
      <i class="fa fa-star" data-value="1"></i>
      <i class="fa fa-star" data-value="2"></i>
      <i class="fa fa-star" data-value="3"></i>
      <i class="fa fa-star" data-value="4"></i>
      <i class="fa fa-star" data-value="5"></i>
    </div>

    <button type="submit">Soumettre</button>
  </form>

  <script>
    const stars = document.querySelectorAll('.etoiles i');
    const noteInput = document.getElementById('note');
    stars.forEach(star => {
      star.addEventListener('click', () => {
        const val = star.getAttribute('data-value');
        noteInput.value = val;
        stars.forEach(s => s.classList.remove('active'));
        for (let i = 0; i < val; i++) stars[i].classList.add('active');
      });
    });
  </script>
</body>
</html>
