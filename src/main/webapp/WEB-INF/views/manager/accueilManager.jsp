<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Annonce - AnnoncesManager</title>
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

        /* Form Content */
        .content-area {
            padding: 40px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .form-card {
            background: var(--light-card);
            border-radius: var(--border-radius);
            padding: 50px;
            box-shadow: var(--shadow-lg);
            border: 1px solid #E2E8F0;
        }

        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .form-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--yale-blue);
            margin-bottom: 12px;
        }

        .form-subtitle {
            color: var(--text-secondary);
            font-size: 1.1rem;
            line-height: 1.5;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            margin-bottom: 12px;
            color: var(--yale-blue);
            font-weight: 600;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
        }

        .input-container {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 1.1rem;
        }

        input, select, textarea {
            width: 100%;
            padding: 16px 20px 16px 50px;
            background: var(--light-bg);
            border: 2px solid #E2E8F0;
            border-radius: 8px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-family: inherit;
        }

        textarea {
            padding: 20px;
            min-height: 140px;
            resize: vertical;
            line-height: 1.5;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--yale-blue);
            box-shadow: 0 0 0 3px rgba(13, 59, 102, 0.1);
            background: white;
        }

        .submit-btn {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, var(--yale-blue), var(--yale-blue-light));
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 20px;
            letter-spacing: 0.5px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            background: linear-gradient(135deg, var(--yale-blue-light), var(--yale-blue));
        }

        .message {
            padding: 20px;
            background: rgba(56, 161, 105, 0.1);
            border: 2px solid var(--success);
            border-radius: 8px;
            color: var(--success);
            margin-top: 30px;
            text-align: center;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .sidebar {
                width: 240px;
            }
            .content-area {
                padding: 30px;
            }
            .form-card {
                padding: 40px;
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
            .form-grid {
                grid-template-columns: 1fr;
            }
            .content-area {
                padding: 20px;
            }
            .form-card {
                padding: 30px 25px;
            }
            .top-header {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
                text-align: center;
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
                    <a href="${pageContext.request.contextPath}/accueilManager" class="nav-link active">
                        <i class="fas fa-plus-circle"></i>
                        <span>Nouvelle Annonce</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/listAnnonceManager" class="nav-link">
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
                <h1 class="page-title">Création d'Annonce</h1>
                <div class="user-menu">
                    <div class="user-avatar">AD</div>
                </div>
            </div>

            <div class="content-area">
                <div class="form-card">
                    <div class="form-header">
                        <h2 class="form-title">Publier une Nouvelle Offre</h2>
                        <p class="form-subtitle">Remplissez les détails de l'annonce pour attirer les meilleurs candidats</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/ajoutAnnonce" method="post">
                        <div class="form-grid">
                            <div class="form-group full-width">
                                <label for="titre">Titre de l'annonce *</label>
                                <div class="input-container">
                                    <i class="fas fa-heading input-icon"></i>
                                    <input type="text" id="titre" name="titre" placeholder="Ex: Développeur Full Stack Senior" required>
                                </div>
                            </div>

                            <div class="form-group full-width">
                                <label for="description">Description du Poste</label>
                                <textarea id="description" name="description" placeholder="Décrivez les responsabilités, missions et compétences requises pour ce poste..."></textarea>
                            </div>

                            <div class="form-group">
                                <label for="ageMin">Âge Minimum</label>
                                <div class="input-container">
                                    <i class="fas fa-user input-icon"></i>
                                    <input type="number" id="ageMin" name="ageMin" min="0" placeholder="18">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="ageMax">Âge Maximum</label>
                                <div class="input-container">
                                    <i class="fas fa-user input-icon"></i>
                                    <input type="number" id="ageMax" name="ageMax" min="0" placeholder="65">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="idDepartement">Département</label>
                                <div class="input-container">
                                    <i class="fas fa-map-marker-alt input-icon"></i>
                                    <select id="idDepartement" name="idDepartement">
                                        <c:forEach var="dep" items="${departements}">
                                            <option value="${dep.id}">${dep.libelleDepartement}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="idDiplomeRequis">Diplôme Requis</label>
                                <div class="input-container">
                                    <i class="fas fa-graduation-cap input-icon"></i>
                                    <select id="idDiplomeRequis" name="idDiplomeRequis">
                                        <c:forEach var="d" items="${diplomes}">
                                            <option value="${d.id}">${d.nomDiplome}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="nbPersonneUtile">Nombre de Postes</label>
                                <div class="input-container">
                                    <i class="fas fa-users input-icon"></i>
                                    <input type="number" id="nbPersonneUtile" name="nbPersonneUtile" min="1" placeholder="1">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="salaire">Salaire Annuel (€)</label>
                                <div class="input-container">
                                    <i class="fas fa-euro-sign input-icon"></i>
                                    <input type="number" id="salaire" name="salaire" min="0" placeholder="45000">
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="submit-btn">
                            <i class="fas fa-paper-plane"></i> Publier l'Annonce
                        </button>
                    </form>
                    
                    <c:if test="${not empty message}">
                        <div class="message">
                            <i class="fas fa-check-circle"></i> ${message}
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>