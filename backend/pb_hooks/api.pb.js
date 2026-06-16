onRecordAfterCreateSuccess((e) => {
    try {
        const record = e.record;
        const productId = record.get("product_id");
        const quantidade = record.get("quantidade");
        const tipo = record.get("tipo"); 
        
        // Buscar o registro do produto (compatível com PB antigo e novo)
        const dao = $app.dao ? $app.dao() : $app;
        const product = dao.findRecordById("products", productId);
        
        let qtdAtual = product.get("quantidade");
        
        // Ajustar a quantidade atual baseada no tipo de movimentação
        if (tipo === "entrada") {
            qtdAtual += quantidade;
        } else if (tipo === "saida") {
            qtdAtual -= quantidade;
            if (qtdAtual < 0) qtdAtual = 0; // Previne estoque negativo
        }
        
        // Atualizar o produto
        product.set("quantidade", qtdAtual);
        if (dao.saveRecord) {
            dao.saveRecord(product);
        } else if (dao.save) {
            dao.save(product);
        }
        
    } catch (error) {
        console.error("Erro ao processar atualização de estoque: " + error.message);
    }
}, "stock_entries");
