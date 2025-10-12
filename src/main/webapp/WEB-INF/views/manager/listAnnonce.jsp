<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Annonces - AnnoncesManager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --yale-blue: #0D3B66;
            --yale-blue-light: #1A5A9B;
            --yale-blue-dark: #082A4D;
            --lemon-chiffon: #FAF0CA;
            --lemon-chiffon-dark: #F5E6B3;
            --light-bg: #F8F9FA;
            --light-surface: #FFFFFF;
            --light-card: #FFFFFF;
            --text-primary: #2D3748;
            --text-secondary: #718096;
            --danger: #E53E3E;
            --warning: #DD6B20;
            --success: #38A169;
            --border-radius: 12px;
            --shadow: 0 8px 32px rgba(13, 59, 102, 0.1);
            --shadow-lg: 0 16px 48px rgba(13, 59, 102, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'SF Pro Display', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, var(--light-bg) 0%, #EDF2F7 100%);
            color: var(--text-primary);
            line-height: 1.6;
            min-height: 100vh;
        }

        .admin-layout {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 280px;
            background: var(--yale-blue);
            padding: 0;
            border-right: 1px solid var(--yale-blue-dark);
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(250, 240, 202, 0.2);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--lemon-chiffon), var(--lemon-chiffon-dark));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--yale-blue);
            font-size: 1.2rem;
            font-weight: bold;
        }

        .logo-text {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--lemon-chiffon);
        }

        .nav-section {
            padding: 25px;
        }

        .nav-title {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: rgba(250, 240, 202, 0.7);
            margin-bottom: 20px;
            font-weight: 600;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            color: rgba(250, 240, 202, 0.8);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            position: relative;
        }

        .nav-link:hover {
            background: rgba(250, 240, 202, 0.1);
            color: var(--lemon-chiffon);
        }

        .nav-link.active {
            background: linear-gradient(135deg, var(--yale-blue-light), var(--yale-blue-dark));
            color: var(--lemon-chiffon);
            box-shadow: 0 4px 16px rgba(13, 59, 102, 0.3);
            border-left: 4px solid var(--lemon-chiffon);
        }

        .nav-link i {
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 0;
            background: var(--light-bg);
        }

        .top-header {
            background: var(--light-surface);
            padding: 20px 40px;
            border-bottom: 1px solid #E2E8F0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--yale-blue);
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--yale-blue), var(--lemon-chiffon-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            border: 2px solid var(--yale-blue);
        }

        /* Content Area */
        .content-area {
            padding: 40px;
        }

        .stats-header {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--light-card);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid #E2E8F0;
            text-align: center;
            box-shadow: var(--shadow);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--yale-blue);
            margin-bottom: 8px;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Annonces Grid */
        .annonces-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(450px, 1fr));
            gap: 25px;
        }

        .annonce-card {
            background: var(--light-card);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid #E2E8F0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
        }

        .annonce-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
            border-color: var(--yale-blue-light);
        }

        .annonce-header {
            padding: 25px 30px 20px;
            border-bottom: 1px solid #E2E8F0;
            background: linear-gradient(135deg, rgba(13, 59, 102, 0.05), transparent);
        }

        .annonce-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--yale-blue);
            margin-bottom: 12px;
            line-height: 1.3;
        }

        .annonce-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .annonce-date {
            color: var(--text-secondary);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .annonce-badge {
            background: linear-gradient(135deg, var(--yale-blue), var(--yale-blue-light));
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .annonce-body {
            padding: 25px 30px;
            flex-grow: 1;
        }

        .annonce-description {
            color: var(--text-secondary);
            margin-bottom: 25px;
            line-height: 1.6;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .annonce-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
        }

        .detail-label {
            font-size: 0.8rem;
            color: var(--text-secondary);
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }

        .detail-value {
            font-weight: 600;
            color: var(--yale-blue);
            font-size: 1rem;
        }

        .annonce-footer {
            padding: 20px 30px;
            background: rgba(13, 59, 102, 0.05);
            border-top: 1px solid #E2E8F0;
            display: flex;
            gap: 12px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 8px;
            flex: 1;
            justify-content: center;
            border: none;
            cursor: pointer;
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger), #C53030);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(229, 62, 62, 0.3);
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning), #C05621);
            color: white;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(221, 107, 32, 0.3);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--yale-blue), var(--yale-blue-light));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 80px 40px;
            background: var(--light-card);
            border-radius: var(--border-radius);
            border: 2px dashed #E2E8F0;
        }

        .empty-icon {
            font-size: 4rem;
            margin-bottom: 25px;
            color: var(--text-secondary);
        }

        .empty-title {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--yale-blue);
            font-weight: 600;
        }

        .empty-text {
            color: var(--text-secondary);
            font-size: 1.1rem;
            margin-bottom: 25px;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .annonces-grid {
                grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .admin-layout {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                height: auto;
            }
            .annonces-grid {
                grid-template-columns: 1fr;
            }
            .content-area {
                padding: 20px;
            }
            .annonce-details {
                grid-template-columns: 1fr;
            }
            .annonce-footer {
                flex-direction: column;
            }
            .stats-header {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="admin-layout">
        <!-- Sidebar Navigation -->
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
                    <a href="${pageContext.request.contextPath}/accueilManager" class="nav-link">
                        <i class="fas fa-plus-circle"></i>
                        <span>Nouvelle Annonce</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/listAnnonceManager" class="nav-link active">
                        <i class="fas fa-list-ol"></i>
                        <span>Gestion des Annonces</span>
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

        <!-- Main Content -->
        <div class="main-content">
            <div class="top-header">
                <h1 class="page-title">Gestion des Annonces</h1>
                <div class="user-menu">
                    <div class="user-avatar">AD</div>
                </div>
            </div>

            <div class="content-area">
                <div class="stats-header">
                    <div class="stat-card">
                        <div class="stat-number">${annonces.size()}</div>
                        <div class="stat-label">Annonces Actives</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="totalPosts" value="0" />
                            <c:forEach var="annonce" items="${annonces}">
                                <c:set var="totalPosts" value="${totalPosts + annonce.nbPersonneUtile}" />
                            </c:forEach>
                            ${totalPosts}
                        </div>
                        <div class="stat-label">Postes Ouverts</div>
                    </div>
                </div>

                <div class="annonces-grid">
                    <c:if test="${empty annonces}">
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="fas fa-inbox"></i>
                            </div>
                            <h2 class="empty-title">Aucune annonce disponible</h2>
                            <p class="empty-text">Commencez par créer votre première annonce pour attirer des candidats</p>
                            <a href="${pageContext.request.contextPath}/accueilManager" class="btn btn-primary" style="max-width: 200px; margin: 0 auto;">
                                <i class="fas fa-plus"></i> Créer une Annonce
                            </a>
                        </div>
                    </c:if>

                    <c:forEach var="annonce" items="${annonces}">
                        <div class="annonce-card">
                            <div class="annonce-header">
                                <h3 class="annonce-title">${annonce.titre}</h3>
                                <div class="annonce-meta">
                                    <div class="annonce-date">
                                        <i class="fas fa-calendar-alt"></i>
                                        ${annonce.datePublication}
                                    </div>
                                    <div class="annonce-badge">Active</div>
                                </div>
                            </div>

                            <div class="annonce-body">
                                <p class="annonce-description">${annonce.description}</p>
                                
                                <div class="annonce-details">
                                    <div class="detail-item">
                                        <span class="detail-label">Tranche d'âge</span>
                                        <span class="detail-value">${annonce.ageMin} - ${annonce.ageMax} ans</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Localisation</span>
                                        <span class="detail-value">${departements[annonce.id]}</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Postes disponibles</span>
                                        <span class="detail-value">${annonce.nbPersonneUtile}</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="detail-label">Salaire annuel</span>
                                        <span class="detail-value">${annonce.salaire} €</span>
                                    </div>
                                </div>
                            </div>

                            <div class="annonce-footer">
                                <a href="${pageContext.request.contextPath}/supprimerAnnonce?id=${annonce.id}" class="btn btn-danger">
                                    <i class="fas fa-trash-alt"></i> Supprimer
                                </a>
                                <a href="${pageContext.request.contextPath}/updateAnnonce?id=${annonce.id}" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</body>
</html>