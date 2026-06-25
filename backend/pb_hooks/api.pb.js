onRecordAfterCreateSuccess((e) => {
    try {
        const record = e.record;
        const productId = record.get("product_id");
        const quantidade = record.get("quantidade");
        const tipo = record.get("tipo"); 
        
        const dao = $app.dao ? $app.dao() : $app;
        const product = dao.findRecordById("products", productId);
        
        let qtdAtual = product.get("quantidade");
        
        if (tipo === "entrada") {
            qtdAtual += quantidade;
        } else if (tipo === "saida") {
            qtdAtual -= quantidade;
            if (qtdAtual < 0) qtdAtual = 0; 
        }
        
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

routerAdd("POST", "/api/v1/processar-entrada", (e) => {
    const info = e.requestInfo();
    const body  = info.body;

    const produtoId  = body["produto_id"];
    const quantidade = parseInt(body["quantidade"]);
    const supplierId = body["supplier_id"] || null;

    if (!produtoId || !quantidade || quantidade <= 0) {
        return e.json(400, {
            mensagem: "produto_id e quantidade (> 0) são obrigatórios"
        });
    }

    try {
        const dao = $app.dao ? $app.dao() : $app;

        const product = dao.findRecordById("products", produtoId);
        if (!product) {
            return e.json(404, { mensagem: "Produto não encontrado" });
        }

        const stockCollection = dao.findCollectionByNameOrId("stock_entries");
        const stockRecord = new Record(stockCollection);
        stockRecord.set("product_id", produtoId);
        stockRecord.set("quantidade", quantidade);
        stockRecord.set("tipo", "entrada");
        if (supplierId) {
            stockRecord.set("supplier_id", supplierId);
        }

        if (dao.saveRecord) {
            dao.saveRecord(stockRecord);
        } else {
            dao.save(stockRecord);
        }

        const produtoAtualizado = dao.findRecordById("products", produtoId);

        return e.json(200, {
            mensagem: "Entrada de estoque processada com sucesso",
            record_id: stockRecord.id,
            produto_id: produtoId,
            quantidade_adicionada: quantidade,
            quantidade_atual: produtoAtualizado.get("quantidade")
        });

    } catch (error) {
        return e.json(500, {
            mensagem: "Erro interno ao processar entrada: " + error.message
        });
    }
});

routerAdd("POST", "/api/v1/processar-saida", (e) => {
    const info = e.requestInfo();
    const body  = info.body;

    const produtoId  = body["produto_id"];
    const quantidade = parseInt(body["quantidade"]);
    const customerId = body["customer_id"] || null;

    if (!produtoId || !quantidade || quantidade <= 0) {
        return e.json(400, {
            mensagem: "produto_id e quantidade (> 0) são obrigatórios"
        });
    }

    try {
        const dao = $app.dao ? $app.dao() : $app;

        const product = dao.findRecordById("products", produtoId);
        if (!product) {
            return e.json(404, { mensagem: "Produto não encontrado" });
        }

        const stockCollection = dao.findCollectionByNameOrId("stock_entries");
        const stockRecord = new Record(stockCollection);
        stockRecord.set("product_id", produtoId);
        stockRecord.set("quantidade", quantidade);
        stockRecord.set("tipo", "saida");
        if (customerId) {
            stockRecord.set("customer_id", customerId);
        }

        if (dao.saveRecord) {
            dao.saveRecord(stockRecord);
        } else {
            dao.save(stockRecord);
        }

        const produtoAtualizado = dao.findRecordById("products", produtoId);

        return e.json(200, {
            mensagem: "Saída de estoque processada com sucesso",
            record_id: stockRecord.id,
            produto_id: produtoId,
            quantidade_removida: quantidade,
            quantidade_atual: produtoAtualizado.get("quantidade")
        });

    } catch (error) {
        return e.json(500, {
            mensagem: "Erro interno ao processar saída: " + error.message
        });
    }
});
