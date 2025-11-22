<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="sidebar">
    <div class="sidebar-header">
        <h1>BusinessSuite RH</h1>
        <p>Gestion des ressources humaines</p>
    </div>
    <div class="nav-menu">

        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/chatbot" class="nav-link active">
                <i class="fas fa-tachometer-alt"></i>
                ChatBot
            </a>
        </div>
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
        <div class="nav-item">
            <a href="#" class="nav-link active">
                <i class="fas fa-user-tie"></i>
                --Congees--
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/conge/attente" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Conge en attente
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/conge/enCours" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Conge en cours
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/conge/refuse" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Conge refusees
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/conge/historique" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Historique des congees
            </a>
        </div>
        <div class="nav-item">
            <a href="#" class="nav-link active">
                <i class="fas fa-user-tie"></i>
                --Paie--
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/paie/preavis" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Gestion paiement des employes
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/paie/list" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Historique des paiements
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/conge/list" class="nav-link active">
                <i class="fas fa-user-tie"></i>
                Liste Congees
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/rh/conge/pointage" class="nav-link active">
                <i class="fas fa-clipboard-check"></i>
                Pointage
            </a>
        </div>
        <div class="nav-item">
            <a href="#" class="nav-link active">
                <i class="fas fa-user-tie"></i>
                --Statistique--
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/statistique/employe" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Statistique Employés
            </a>
        </div>
         <div class="nav-item">
            <a href="${pageContext.request.contextPath}/statistique/contrat" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Statistique Contrats
            </a>
        </div>
         <div class="nav-item">
            <a href="${pageContext.request.contextPath}/statistique/conge" class="nav-link">
                <i class="fas fa-user-tie"></i>
                Statistique Absentéisme
            </a>
        </div>
    </div>
</nav>
