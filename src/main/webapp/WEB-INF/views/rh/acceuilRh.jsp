<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord RH - BusinessSuite</title>
    <style>
        /* Variables CSS - Palette Navy Blue + Cream + White */
        :root {
            --navy-blue: #1A365D;
            --navy-light: #2D4A7C;
            --navy-dark: #0F1F3D;
            --cream: #F8F9FA;
            --cream-dark: #E9ECEF;
            --white: #FFFFFF;
            --gray: #6C757D;
            --gray-light: #DEE2E6;
            --gray-lighter: #F8F9FA;
            --accent: #2563EB;
            --success: #198754;
            --warning: #FFC107;
            --info: #0DCAF0;
            --border-radius: 8px;
            --box-shadow: 0 2px 10px rgba(26, 54, 93, 0.08);
            --transition: all 0.3s ease;
        }

        /* Reset et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            line-height: 1.5;
            color: var(--navy-blue);
            background: var(--cream);
            min-height: 100vh;
        }

        /* Layout Principal */
        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 280px;
            background: var(--navy-blue);
            color: var(--white);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: var(--transition);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--navy-light);
        }

        .sidebar-header h1 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .sidebar-header p {
            font-size: 0.875rem;
            color: var(--gray-light);
            opacity: 0.8;
        }

        .nav-menu {
            padding: 1.5rem 0;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.875rem 1.5rem;
            color: var(--white);
            text-decoration: none;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--navy-light);
            border-left-color: var(--accent);
        }

        .nav-link i {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
        }

        /* Contenu Principal */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        /* Top Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .page-title h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.25rem;
        }

        .page-title p {
            color: var(--gray);
            font-size: 0.9rem;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logout-btn {
            background: var(--navy-blue);
            color: var(--white);
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition);
        }

        .logout-btn:hover {
            background: var(--navy-light);
        }

        /* Section Dashboard */
        .dashboard-section {
            margin-bottom: 2rem;
        }

        .dashboard-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .dashboard-header h3 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--navy-blue);
        }

        .view-all-link {
            color: var(--navy-blue);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .view-all-link:hover {
            color: var(--navy-light);
        }

        /* Cartes de Statistiques */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            border-left: 4px solid var(--navy-blue);
            transition: var(--transition);
            cursor: pointer;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(26, 54, 93, 0.12);
        }

        .stat-card.success {
            border-left-color: var(--success);
        }

        .stat-card.warning {
            border-left-color: var(--warning);
        }

        .stat-card.info {
            border-left-color: var(--info);
        }

        .stat-card h3 {
            font-size: 0.875rem;
            color: var(--gray);
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.5rem;
        }

        .stat-trend {
            font-size: 0.875rem;
            color: var(--success);
        }

        /* Section Actions Rapides */
        .quick-actions {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .quick-actions h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--navy-blue);
            margin-bottom: 1rem;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .action-card {
            background: var(--gray-lighter);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            color: var(--navy-blue);
            transition: var(--transition);
            border: 1px solid var(--gray-light);
        }

        .action-card:hover {
            background: var(--navy-blue);
            color: var(--white);
            transform: translateY(-2px);
        }

        .action-card i {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            display: block;
        }

        .action-card span {
            font-weight: 600;
            font-size: 0.9rem;
        }

        /* Section Candidats Récents */
        .recent-candidates {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
        }

        .section-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--gray-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--navy-blue);
        }

        .candidates-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
        }

        .candidates-table th {
            background: var(--gray-lighter);
            color: var(--navy-blue);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 1px solid var(--gray-light);
        }

        .candidates-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .candidates-table tbody tr:hover {
            background: var(--gray-lighter);
        }

        .candidates-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Badges et Actions */
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .status-noted {
            background: var(--navy-blue);
            color: var(--white);
        }

        .status-not-rated {
            background: var(--gray-light);
            color: var(--gray);
        }

        .action-link {
            color: var(--navy-blue);
            text-decoration: none;
            font-weight: 500;
            padding: 0.25rem 0.5rem;
            border-radius: var(--border-radius);
            transition: var(--transition);
            border: 1px solid transparent;
        }

        .action-link:hover {
            background: var(--navy-blue);
            color: var(--white);
            border-color: var(--navy-blue);
        }

        /* Message de bienvenue */
        .welcome-message {
            background: linear-gradient(135deg, var(--navy-blue), var(--navy-light));
            color: var(--white);
            padding: 2rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            box-shadow: var(--box-shadow);
        }

        .welcome-message h2 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .welcome-message p {
            opacity: 0.9;
            font-size: 0.95rem;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .actions-grid {
                grid-template-columns: 1fr;
            }
            .top-bar {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
            .recent-candidates {
                overflow-x: auto;
            }
            .candidates-table {
                min-width: 600px;
            }
        }

        @media (max-width: 576px) {
            .welcome-message {
                padding: 1.5rem;
            }
            .section-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar Navigation -->
        <jsp:include page="sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Tableau de Bord RH</h2>
                    <p>Vue d'ensemble de votre activité</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </div>
            </div>

            <!-- Message de bienvenue -->
            <div class="welcome-message">
                <h2>Bienvenue dans votre espace RH</h2>
                <p>Gérez efficacement vos candidats, entretiens et employés depuis ce tableau de bord.</p>
            </div>

            <c:if test="${not empty success}">
                <div class="success-message">${success}</div>
            </c:if>

            <!-- Cartes de Statistiques -->
            <!-- <div class="stats-grid">
                <div class="stat-card" onclick="location.href='${pageContext.request.contextPath}/rh/candidats'">
                    <h3>Candidats Admis</h3>
                    <div class="stat-number">${candidatsAdmis.size()}</div>
                    <div class="stat-trend">+12% ce mois</div>
                </div> -->
                <!-- <div class="stat-card success" onclick="location.href='${pageContext.request.contextPath}/rh/employe'">
                    <h3>Employés Actifs</h3>
                    <div class="stat-number">47</div>
                    <div class="stat-trend">+5% ce trimestre</div>
                </div>
                <div class="stat-card warning" onclick="location.href='${pageContext.request.contextPath}/rh/essai'">
                    <h3>En Période d'Essai</h3>
                    <div class="stat-number">8</div>
                    <div class="stat-trend">3 à évaluer</div>
                </div>
                <div class="stat-card info" onclick="location.href='${pageContext.request.contextPath}/rh/listCandidatRefuse'">
                    <h3>Candidats Refusés</h3>
                    <div class="stat-number">23</div>
                    <div class="stat-trend">-8% ce mois</div>
                </div>
            </div> -->

            <!-- Actions Rapides -->
            <div class="quick-actions">
                <h3>Actions Rapides</h3>
                <div class="actions-grid">
                    <!-- <a href="${pageContext.request.contextPath}/rh/listCandidat" class="action-card">
                        <i class="fas fa-user-check"></i>
                        <span>Voir Candidats Admis</span>
                    </a> -->
                    <a href="${pageContext.request.contextPath}/rh/candidats" class="action-card">
                        <i class="fas fa-list"></i>
                        <span>Tous les Candidats</span>
                    </a>
                    <!-- <a href="${pageContext.request.contextPath}/rh/entretien" class="action-card">
                        <i class="fas fa-calendar-plus"></i>
                        <span>Planifier Entretien</span>
                    </a> -->
                    <a href="${pageContext.request.contextPath}/rh/employe" class="action-card">
                        <i class="fas fa-user-tie"></i>
                        <span>Gérer Employés</span>
                    </a>
                </div>
            </div>

            <!-- Candidats Récents -->
            <div class="dashboard-section">
                <div class="dashboard-header">
                    <h1>Candidats Récemment Admis</h1>
                    <!-- <a href="${pageContext.request.contextPath}/rh/candidats" class="view-all-link">
                        Voir tout
                        <i class="fas fa-arrow-right"></i>
                    </a> -->
                </div>
                
                <div class="recent-candidates">
                    <div class="section-header">
                        <h2>Dernières admissions</h2>
                    </div>
                    
                    <table class="candidates-table">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Prénom</th>
                                <th>Département</th>
                                <th>Note QCM</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="candidat" items="${candidatsAdmis}" begin="0" end="4">
                                <tr>
                                    <td><strong>${candidat.nom}</strong></td>
                                    <td>${candidat.prenom}</td>
                                    <td>${candidat.departement}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${candidat.noteQcm != null}">
                                                <span class="status-badge status-noted">${candidat.noteQcm}%</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-not-rated">Non noté</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${candidat.datePostule}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/rh/entretien?id_cand=${candidat.id}" class="action-link" title="Planifier entretien">
                                            <i class="fas fa-calendar-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Script pour le dashboard interactif
        document.addEventListener('DOMContentLoaded', function() {
            // Animation des cartes de statistiques
            const statCards = document.querySelectorAll('.stat-card');
            statCards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });

            // Gestion du menu responsive
            const menuToggle = document.createElement('button');
            menuToggle.innerHTML = '<i class="fas fa-bars"></i>';
            menuToggle.style.cssText = `
                position: fixed;
                top: 1rem;
                left: 1rem;
                background: var(--navy-blue);
                color: white;
                border: none;
                padding: 0.5rem;
                border-radius: var(--border-radius);
                cursor: pointer;
                z-index: 1001;
                display: none;
            `;
            
            document.body.appendChild(menuToggle);
            
            menuToggle.addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('active');
            });

            // Cacher le toggle sur desktop
            function handleResize() {
                if (window.innerWidth <= 992) {
                    menuToggle.style.display = 'block';
                } else {
                    menuToggle.style.display = 'none';
                    document.querySelector('.sidebar').classList.remove('active');
                }
            }

            window.addEventListener('resize', handleResize);
            handleResize();
        });
    </script>
</body>
</html>