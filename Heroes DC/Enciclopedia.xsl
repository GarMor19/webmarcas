<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <xsl:template match="/">
        <html lang="es">
            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Enciclopedia DC</title>
                <style>
                    body {
                        margin: 0;
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background-color: #1c1c1c;
                        color: #f5f5f5;
                    }
                    
                    .navbar {
                        display: flex;
                        align-items: center;
                        justify-content: space-between; /* Distribuye los elementos */
                        background: linear-gradient(to right, #000000, #1e90ff);
                        padding: 10px 20px;
                    }

                    .navbar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        background: linear-gradient(to right, #000000, #1e90ff);
                        padding: 10px 20px;
                    }

                    .navbar .logo img {
                        height: 120px;
                    }

                    .navbar .redes {
                        display: flex;
                        gap: 15px;
                    }

                    .navbar .redes a img {
                        height: 30px;
                        transition: transform 0.3s ease;
                    }

                    .navbar .redes a img:hover {
                        transform: scale(1.1);
                    }

                    h1 {
                        text-align: center;
                        padding: 20px;
                        font-size: 2.5em;
                        color: #ffffff;
                        background: linear-gradient(to right, #000000, #1e90ff);
                        margin: 0;
                    }

                    .galeria {
                        display: flex;
                        flex-wrap: wrap;
                        justify-content: center;
                        padding: 20px;
                        gap: 20px;
                    }

                    .personaje {
                        background-color: #2b2b2b;
                        border-radius: 12px;
                        padding: 15px;
                        width: 260px;
                        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
                        transition: transform 0.3s ease, filter 0.3s ease;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        position: relative;
                    }

                    .personaje img {
                        width: 100%;
                        height: auto;
                        border-radius: 10px;
                        cursor: pointer;
                        transition: transform 0.3s ease;
                    }

                    .personaje .nombre {
                        font-size: 20px;
                        font-weight: bold;
                        margin-top: 10px;
                        color: #1e90ff;
                        text-align: center;
                    }

                    .descripcion {
                        display: none;
                        margin-top: 10px;
                        background-color: #3a3a3a;
                        padding: 10px;
                        border-radius: 8px;
                        font-size: 14px;
                        color: #ddd;
                        width: 100%;
                    }

                    .descripcion.show {
                        display: block;
                    }

                    .personaje.seleccionado {
                        transform: scale(1.05);
                        z-index: 2;
                        box-shadow: 0 0 15px #1e90ff;
                    }

                    .personaje.opaco {
                        filter: brightness(40%);
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .personaje {
                            width: 80%;
                        }
                    }

                    @media (max-width: 480px) {
                        h1 {
                            font-size: 1.8em;
                        }
                    }
                </style>
                <script type="text/javascript">
                    function toggleSeleccion(id) {
                        const personaje = document.getElementById(id);
                        const yaSeleccionado = personaje.classList.contains("seleccionado");
                        const todos = document.querySelectorAll(".personaje");

                        todos.forEach(p => {
                            p.classList.remove("seleccionado", "opaco");
                            p.querySelector(".descripcion").classList.remove("show");
                        });

                        if (!yaSeleccionado) {
                            personaje.classList.add("seleccionado");
                            personaje.querySelector(".descripcion").classList.add("show");

                            todos.forEach(p => {
                                if (p.id !== id) {
                                    p.classList.add("opaco");
                                }
                            });
                        }
                    }
                </script>
            </head>
            <body>
                <div class="navbar">
                    <div class="logo">
                        <img src="./Imagenes/DC.png" alt="DC Comics Logo" />
                    </div>
                    <div class="redes">
                        <a href="https://www.instagram.com/dcofficial/" target="_blank"><img src="./Imagenes/ig.png" alt="Instagram" /></a>
                        <a href="https://www.facebook.com/dcofficial/" target="_blank"><img src="./Imagenes/Facebook.png" alt="Facebook" /></a>
                        <a href="https://x.com/DCOfficial" target="_blank"><img src="./Imagenes/twitter.png" alt="X" /></a>
                        <a href="https://www.tiktok.com/@dc" target="_blank"><img src="./Imagenes/TikTok.png" alt="TikTok" /></a>
                    </div>
                </div>
                <h1>Enciclopedia de Personajes DC</h1>
                <div class="galeria">
                    <xsl:for-each select="enciclopediaDC/personaje">
                        <div class="personaje" id="personaje_{position()}">
                            <div class="nombre">
                                <xsl:value-of select="nombre" />
                            </div>
                            <img src="{imagen}" alt="{nombre}" onclick="toggleSeleccion('personaje_{position()}')" />
                            <div class="descripcion">
                                <p><strong>Nombre real: </strong> <xsl:value-of select="nombreReal" /></p>
                                <p><strong>Alias: </strong> <xsl:value-of select="alias" /></p>
                                <p><strong>Grupo: </strong> 
                                    <xsl:for-each select="afiliaciones/grupo">
                                        <xsl:value-of select="." />
                                        <xsl:if test="position() != last()">, </xsl:if>
                                    </xsl:for-each>
                                </p>
                                <p><strong>Poderes: </strong> 
                                    <xsl:for-each select="poderes/poder">
                                        <xsl:value-of select="." />
                                        <xsl:if test="position() != last()">, </xsl:if>
                                    </xsl:for-each>
                                </p>
                                <p><strong>Debilidades: </strong> 
                                    <xsl:for-each select="debilidades/debilidad">
                                        <xsl:value-of select="." />
                                        <xsl:if test="position() != last()">, </xsl:if>
                                    </xsl:for-each>
                                </p>
                                <p><strong>Ciudad: </strong> <xsl:value-of select="ciudad" /></p>
                                <p><strong>Primera aparición: </strong> <xsl:value-of select="primeraAparicion" /></p>
                                <p><strong>Editorial: </strong> <xsl:value-of select="editorial" /></p>
                            </div>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
