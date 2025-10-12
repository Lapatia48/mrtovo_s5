<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo">
            <div class="logo-icon">
                <i class="fas fa-briefcase"></i>
            </div>
            <div class="logo-text">MANAGER</div>
        </div>
    </div>

    <div class="nav-section">
        <div class="nav-title">Navigation Principale</div>
        <div class="nav-links">
            <!-- annonce -->
            <a href="${pageContext.request.contextPath}/accueilManager" class="nav-link active">
                <i class="fas fa-plus-circle"></i>
                <span>Nouvelle Annonce</span>
            </a>
            <a href="${pageContext.request.contextPath}/listAnnonceManager" class="nav-link active">
                <i class="fas fa-list-ol"></i>
                <span>Gestion des Annonces</span>
            </a>

            <!-- qcm -->
            <a href="${pageContext.request.contextPath}/manager/listQcm" class="nav-link active">
                <i class="fas fa-list-ol"></i>
                <span>Gestion des QCM</span>
            </a>            
            <a href="${pageContext.request.contextPath}/manager/ajoutQcm" class="nav-link active">
                <i class="fas fa-plus-circle"></i>
                <span>Ajouter QCM</span>
            </a>
        </div>
    </div>

    <div class="nav-section" style="margin-top: auto; padding-bottom: 30px;">
        <div class="nav-title">Compte</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/entrer" class="nav-link">
                <i class="fas fa-sign-out-alt"></i>
                <span>Déconnexion</span>
            </a>
        </div>
    </div>
</div>
