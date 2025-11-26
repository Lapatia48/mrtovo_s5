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
            <a href="${pageContext.request.contextPath}/accueilRh" class="nav-link">
                <i class="fas fa-tachometer-alt"></i>
                Tableau de Bord
            </a>
        </div>

        <!-- Section Statistiques avec dropdown -->
        <div class="nav-item nav-group">
            <button class="nav-link nav-toggle" data-toggle="stats-menu">
                <i class="fas fa-clipboard-check"></i>
                STATISTIQUES
                <i class="fas fa-chevron-down nav-chevron"></i>
            </button>
            <div class="nav-submenu" id="stats-menu">
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/statistiques/dashboard" class="nav-link">
                        <i class="fas fa-chart-bar"></i>
                        Stats employes
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/statistiques/performance-rh" class="nav-link">
                        <i class="fas fa-chart-line"></i>
                        Stats entreprise
                    </a>
                </div>
            </div>
        </div>

        <!-- Section CANDIDATS avec dropdown -->
        <div class="nav-item nav-group">
            <button class="nav-link nav-toggle" data-toggle="candidats-menu">
                <i class="fas fa-users"></i>
                CANDIDATS
                <i class="fas fa-chevron-down nav-chevron"></i>
            </button>
            <div class="nav-submenu" id="candidats-menu">
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/candidats" class="nav-link">
                        <i class="fas fa-users"></i>
                        Tous les candidats 
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/listCandidatRefuse" class="nav-link">
                        <i class="fas fa-user-times"></i>
                        Candidats Refusés
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/essai" class="nav-link">
                        <i class="fas fa-clock"></i>
                        Période d'Essai
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/essaiRenouv" class="nav-link">
                        <i class="fas fa-sync-alt"></i>
                        Renouvellement Essai
                    </a>
                </div>
            </div>
        </div>

        <!-- Section EMPLOYÉS avec dropdown -->
        <div class="nav-item nav-group">
            <button class="nav-link nav-toggle" data-toggle="employes-menu">
                <i class="fas fa-user-tie"></i>
                EMPLOYÉS
                <i class="fas fa-chevron-down nav-chevron"></i>
            </button>
            <div class="nav-submenu" id="employes-menu">
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/employe" class="nav-link">
                        <i class="fas fa-user-tie"></i>
                        Gestion des employés
                    </a>
                </div>
            </div>
        </div>

        <!-- Section Congées avec dropdown -->
        <div class="nav-item nav-group">
            <button class="nav-link nav-toggle" data-toggle="conge-menu">
                <i class="fas fa-umbrella"></i>
                CONGÉS
                <i class="fas fa-chevron-down nav-chevron"></i>
            </button>
            <div class="nav-submenu" id="conge-menu">
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/conge/attente" class="nav-link">
                        <i class="fas fa-hourglass-half"></i>
                        Congé en attente
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/conge/enCours" class="nav-link">
                        <i class="fas fa-play-circle"></i>
                        Congé en cours
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/conge/refuse" class="nav-link">
                        <i class="fas fa-times-circle"></i>
                        Congé refusés
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/conge/historique" class="nav-link">
                        <i class="fas fa-history"></i>
                        Historique des congés
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/conge/list" class="nav-link">
                        <i class="fas fa-list"></i>
                        Liste Congés
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/conge/pointage" class="nav-link">
                        <i class="fas fa-clipboard-check"></i>
                        Pointage
                    </a>
                </div>
            </div>
        </div>

        <!-- Section Paie avec dropdown -->
        <div class="nav-item nav-group">
            <button class="nav-link nav-toggle" data-toggle="paie-menu">
                <i class="fas fa-money-bill-wave"></i>
                PAIE
                <i class="fas fa-chevron-down nav-chevron"></i>
            </button>
            <div class="nav-submenu" id="paie-menu">
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/paie/preavis" class="nav-link">
                        <i class="fas fa-handshake"></i>
                        Gestion paiement des employés
                    </a>
                </div>
                <div class="nav-item nav-subitem">
                    <a href="${pageContext.request.contextPath}/rh/paie/list" class="nav-link">
                        <i class="fas fa-list-ul"></i>
                        Historique des paiements
                    </a>
                </div>
            </div>
        </div>

    </div>
</nav>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Récupérer tous les boutons de toggle
        const toggleButtons = document.querySelectorAll('.nav-toggle');
        
        toggleButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Récupérer l'ID du menu à afficher/masquer
                const menuId = this.getAttribute('data-toggle');
                const menu = document.getElementById(menuId);
                const chevron = this.querySelector('.nav-chevron');
                
                // Vérifier si le menu est actuellement visible
                const isOpen = menu.classList.contains('open');
                
                // SUPPRIMÉ la fermeture automatique des autres menus
                // Chaque menu reste indépendant
                
                // Toggle le menu actuel
                if (isOpen) {
                    menu.classList.remove('open');
                    chevron.classList.remove('rotated');
                } else {
                    menu.classList.add('open');
                    chevron.classList.add('rotated');
                }
            });
        });
        
        // SUPPRIMÉ la fermeture automatique au clic sur les liens
        // Les menus restent ouverts même après avoir cliqué sur un lien
    });
</script>

<style>
    /* Styles pour les menus déroulants */
    .nav-toggle {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        border: none;
        background: transparent;
        cursor: pointer;
        padding: inherit;
        font-size: inherit;
        color: inherit;
        text-align: left;
        transition: all 0.3s ease;
        font-weight: bold;
        font-size: 1.05em;
    }
    
    .nav-toggle:hover {
        background-color: rgba(0, 0, 0, 0.05);
    }
    
    .nav-chevron {
        transition: transform 0.3s ease;
        margin-left: auto;
    }
    
    .nav-chevron.rotated {
        transform: rotate(180deg);
    }
    
    .nav-submenu {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease;
        padding-left: 20px;
    }
    
    .nav-submenu.open {
        max-height: 500px;
    }
    
    .nav-subitem {
        margin: 8px 0;
    }
    
    .nav-subitem .nav-link {
        padding-left: 10px;
        font-size: 0.9em;
    }
    
    /* Style pour les menus principaux (textes agrandis et espacés) */
    .nav-group .nav-toggle {
        font-size: 1.1em;
        font-weight: 600;
        padding: 15px 20px;
        margin: 8px 0;
        border-radius: 8px;
        background-color: rgba(0, 0, 0, 0.02);
    }
    
    /* Espacement supplémentaire entre les groupes principaux */
    .nav-group {
        margin: 12px 0;
    }
    
    /* Style pour les liens simples aussi */
    .nav-item:not(.nav-group) .nav-link {
        padding: 15px 20px;
        margin: 8px 0;
        border-radius: 8px;
        display: block;
    }
    
    .nav-item:not(.nav-group) .nav-link:hover {
        background-color: rgba(0, 0, 0, 0.05);
    }
</style>