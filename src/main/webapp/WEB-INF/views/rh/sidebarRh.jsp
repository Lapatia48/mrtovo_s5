<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="sidebar">
    <div class="sidebar-header">
        <h1>BusinessSuite RH</h1>
        <p>Gestion des ressources humaines</p>
    </div>
    <div class="nav-menu">
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/accueilRh" class="nav-link active">
                <i class="fas fa-tachometer-alt"></i>
                Tableau de Bord
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/candidats" class="nav-link">
                <i class="fas fa-users"></i>
                Tout les candidats 
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/listCandidatRefuse" class="nav-link">
                <i class="fas fa-user-times"></i>
                Candidats Refusés
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/essai" class="nav-link">
                <i class="fas fa-clock"></i>
                Période d'Essai
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/essaiRenouv" class="nav-link">
                <i class="fas fa-sync-alt"></i>
                Renouvellement Essai
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/employe" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Employés
            </a>
        </div>
    </div>
</nav>