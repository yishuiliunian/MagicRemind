//
//  MRGraphic.hpp
//  Pods
//
//  Created by baidu on 16/4/15.
//
//

#ifndef MRGraphic_hpp
#define MRGraphic_hpp

#include <stdio.h>
#include <vector>
#include <map>

namespace MagicRecord {
    
    class MRArc;
    
    class MRNode {
    private:
        char* identy;
    public:
        MRNode(const char* identifier);
        ~MRNode();
        MRArc* firstIn;
        const char* identifier();
        MRArc* firstOut;
        bool operator=(MRNode* node);
    };
    
    class MRArc {
    public:
        MRNode* headNode;
        MRNode* tailNode;
        //
        MRArc* inLink;
        MRArc* outLink;
    };
    
    class MRGraphic {
    private:
        std::vector<MRNode*> nodes;
        std::vector<MRArc> arcs;
    public:
        MRGraphic();
        bool isNodeExist(const char * identifier);
        void insertNode(const char * identifier);
        void insertArc(const char* node1,const  char* node2);
        bool circleCheck(MRNode node, std::map<const char*, bool>& visit, std::vector<MRNode>& father);
        MRNode* nodeWithIdentifer(const char* identifier);
    };
 
}


#endif /* MRGraphic_hpp */
