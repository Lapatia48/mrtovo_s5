<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier QCM - AnnoncesManager</title>
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
            --warning: #D69E2E;
            --danger: #E53E3E;
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
            max-width: 800px;
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

        .form-group {
            margin-bottom: 30px;
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

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--yale-blue);
            box-shadow: 0 0 0 3px rgba(13, 59, 102, 0.1);
            background: white;
        }

        /* Réponses Section */
        .reponses-section {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-top: 10px;
            border: 2px dashed #E2E8F0;
        }

        .reponses-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 20px;
        }

        .reponses-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--yale-blue);
        }

        .reponse-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
            padding: 15px;
            background: white;
            border-radius: 8px;
            border: 2px solid #E2E8F0;
            transition: all 0.2s ease;
        }

        .reponse-item:focus-within {
            border-color: var(--yale-blue);
            box-shadow: 0 0 0 3px rgba(13, 59, 102, 0.1);
        }

        .reponse-input {
            flex: 1;
            padding: 12px 16px;
            border: 1px solid #E2E8F0;
            border-radius: 6px;
            font-size: 0.95rem;
        }

        .reponse-input:focus {
            outline: none;
            border-color: var(--yale-blue);
        }

        .radio-group {
            display: flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
            font-weight: 500;
            color: var(--text-secondary);
        }

        input[type="radio"] {
            width: 18px;
            height: 18px;
            margin: 0;
        }

        .delete-btn {
            background: rgba(229, 62, 62, 0.1);
            color: var(--danger);
            border: 1px solid rgba(229, 62, 62, 0.3);
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.85rem;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .delete-btn:hover {
            background: var(--danger);
            color: white;
        }

        .add-reponse-btn {
            background: rgba(13, 59, 102, 0.1);
            color: var(--yale-blue);
            border: 2px dashed var(--yale-blue);
            padding: 14px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            justify-content: center;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .add-reponse-btn:hover {
            background: var(--yale-blue);
            color: white;
            border-style: solid;
        }

        /* Actions Section */
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .submit-btn {
            flex: 2;
            padding: 18px;
            background: linear-gradient(135deg, var(--yale-blue), var(--yale-blue-light));
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            background: linear-gradient(135deg, var(--yale-blue-light), var(--yale-blue));
        }

        .cancel-btn {
            flex: 1;
            padding: 18px;
            background: var(--light-bg);
            color: var(--text-secondary);
            border: 2px solid #E2E8F0;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .cancel-btn:hover {
            background: white;
            border-color: var(--yale-blue);
            color: var(--yale-blue);
            transform: translateY(-2px);
            box-shadow: var(--shadow);
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
            .reponse-item {
                flex-direction: column;
                align-items: stretch;
                gap: 10px;
            }
            .radio-group {
                justify-content: flex-start;
            }
            .form-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="admin-layout">
        <!-- Sidebar Navigation -->
        <jsp:include page="sidebarManager.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <div class="top-header">
                <h1 class="page-title">Modification de QCM</h1>
                <div class="user-menu">
                    <div class="user-avatar">AD</div>
                </div>
            </div>

            <div class="content-area">
                <div class="form-card">
                    <div class="form-header">
                        <h2 class="form-title">Modifier le Questionnaire</h2>
                        <p class="form-subtitle">Mettez à jour la question et les réponses du QCM</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/manager/updateQcm" method="post">
                        <input type="hidden" name="id_question" value="${questionId}">
                        
                        <!-- Sélection du département -->
                        <div class="form-group">
                            <label for="id_departement">Département</label>
                            <div class="input-container">
                                <i class="fas fa-map-marker-alt input-icon"></i>
                                <select id="id_departement" name="id_departement" required>
                                    <c:forEach var="departement" items="${departements}">
                                        <option value="${departement.id}" 
                                            <c:if test="${departement.id == idDepartement}">selected</c:if>>
                                            ${departement.libelleDepartement}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Question -->
                        <div class="form-group">
                            <label for="question">Question</label>
                            <div class="input-container">
                                <i class="fas fa-question-circle input-icon"></i>
                                <input type="text" id="question" name="question" value="${questionText}" placeholder="Entrez la question du QCM" required>
                            </div>
                        </div>
                        
                        <!-- Réponses -->
                        <div class="form-group">
                            <label>Réponses</label>
                            <div class="reponses-section">
                                <div id="reponses-container">
                                    <c:forEach var="reponse" items="${qcmDetails}" varStatus="status">
                                        <div class="reponse-item">
                                            <input type="text" class="reponse-input" name="reponses" value="${reponse.reponse}" required>
                                            <div class="radio-group">
                                                <input type="radio" name="reponse_correcte" value="${status.index}" 
                                                    <c:if test="${reponse.estVraie}">checked</c:if> required>
                                                <span>Correcte</span>
                                            </div>
                                            <c:if test="${status.index >= 2}">
                                                <button type="button" class="delete-btn" onclick="supprimerReponse(this)">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                                
                                <button type="button" class="add-reponse-btn" onclick="ajouterReponse()">
                                    <i class="fas fa-plus"></i> Ajouter une réponse
                                </button>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="submit" class="submit-btn">
                                <i class="fas fa-save"></i> Modifier le QCM
                            </button>
                            <a href="${pageContext.request.contextPath}/manager/listQcm" class="cancel-btn">
                                <i class="fas fa-times"></i> Annuler
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        let reponseCount = ${qcmDetails.size()};
        
        function ajouterReponse() {
            reponseCount++;
            const container = document.getElementById('reponses-container');
            
            const div = document.createElement('div');
            div.className = 'reponse-item';
            div.innerHTML = `
                <input type="text" class="reponse-input" name="reponses" placeholder="Réponse ${reponseCount}" required>
                <div class="radio-group">
                    <input type="radio" name="reponse_correcte" value="${reponseCount - 1}">
                    <span>Correcte</span>
                </div>
                <button type="button" class="delete-btn" onclick="supprimerReponse(this)">
                    <i class="fas fa-times"></i>
                </button>
            `;
            container.appendChild(div);
            
            // Mettre à jour l'affichage des boutons de suppression
            mettreAJourBoutonsSuppression();
        }
        
        function supprimerReponse(button) {
            if (document.querySelectorAll('.reponse-item').length > 2) {
                button.parentElement.remove();
                reponseCount--;
                // Recalculer les valeurs des radio buttons
                const radios = document.querySelectorAll('input[name="reponse_correcte"]');
                radios.forEach((radio, index) => {
                    radio.value = index;
                });
                
                // Mettre à jour l'affichage des boutons de suppression
                mettreAJourBoutonsSuppression();
            } else {
                alert('Au moins 2 réponses sont nécessaires');
            }
        }
        
        function mettreAJourBoutonsSuppression() {
            const reponseItems = document.querySelectorAll('.reponse-item');
            reponseItems.forEach((item, index) => {
                const deleteBtn = item.querySelector('.delete-btn');
                if (deleteBtn) {
                    // Cacher le bouton de suppression pour les 2 premières réponses
                    deleteBtn.style.display = index < 2 ? 'none' : 'flex';
                }
            });
        }
        
        // Initialiser l'affichage des boutons de suppression au chargement
        document.addEventListener('DOMContentLoaded', function() {
            mettreAJourBoutonsSuppression();
        });
    </script>
</body>
</html>